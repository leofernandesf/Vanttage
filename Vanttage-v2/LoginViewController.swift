//
//  LoginViewController.swift
//  Vanttage
//
//  Created by leo on 21/09/16.
//  Copyright © 2016 tap4. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    let myLayout = layout()
    var logInFace: FBSDKLoginManager?
    var informacoes: Cadastro?
    @IBOutlet weak var tfNome: UITextField!
    @IBOutlet weak var tfPassword: UITextField!
    
    @IBOutlet weak var entrar: UIButton!
    @IBOutlet weak var inscrever: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myLayout.buttonLayout(objeto: [entrar, inscrever],color: UIColor.white.cgColor,borderWidth: 1.2)
        self.hideKeyboardWhenTappedAround()
        layout.tfLayout(tf: [tfNome,tfPassword], image: nil)
        logInFace = FBSDKLoginManager()
        logInFace?.logOut()
        
        
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "cadastrar" {
            if let _ = FBSDKAccessToken.current() {
                let viiewController:CriarContaViewController = segue.destination as! CriarContaViewController
                viiewController.informacoes = self.informacoes
            }
            
            
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        print("will")
        if let _ = FBSDKAccessToken.current() {
            self.graphRequest()
        }
    }
    
    @IBAction func esqueciSenha(_ sender: AnyObject) {
        
        performSegue(withIdentifier: "senha", sender: self)
//        let VC1 = self.storyboard!.instantiateViewController(withIdentifier: "senha") as! LembrarSenhaViewController
//        self.navigationController!.pushViewController(VC1, animated: true)
    }
    
    @IBAction func cadastrar(_ sender: AnyObject) {
        performSegue(withIdentifier: "cadastrar", sender: self)
    }
    
    
    
    @IBAction func logarFacebook(_ sender: AnyObject) {
        print("clicou")
        
        logInFace?.logIn(withReadPermissions: ["email","public_profile"], from: self) { (result, error) in
            if (error != nil) {
                print("Erro em logar",error)
            } else if (result?.isCancelled)! {
                print("CANCELADO")
            } else {
                print("logado")
            }
        }
    }
    
    func graphRequest() {
        
        FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "id, name, picture.type(large), email"]).start { (connection, result, error) in
            if error != nil {
                print(error)
                return
            }
            
            self.informacoes = Cadastro()
            let data:[String:AnyObject] = result as! [String : AnyObject]
            print(data)
            if let email = data["email"] as? String {
                self.informacoes?.email = email
            }
            
            if data["picture"] != nil {
                let pic = data["picture"] as! NSDictionary
                let data = pic["data"] as! NSDictionary
                let url = data["url"] as! String
                
                if let url = NSURL(string: url), let data = NSData(contentsOf: url as URL), let downloadedImage = UIImage(data: data as Data) {
                    self.informacoes?.imagem = downloadedImage
                }
            }
            
            if let name = data["name"] as? String {
                self.informacoes?.nome = name
            }
            
            print(self.informacoes?.email)
            print(self.informacoes?.imagem)
            print(self.informacoes?.nome)
            self.performSegue(withIdentifier: "cadastrar", sender: self)
            
            
        }
    }
    
    
}

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
}
