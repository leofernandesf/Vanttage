//
//  LoginViewController.swift
//  Vanttage
//
//  Created by leo on 21/09/16.
//  Copyright © 2016 tap4. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var load: UIActivityIndicatorView!
    @IBOutlet weak var visulaeffect: UIVisualEffectView!
    let myLayout = layout()
    var logInFace: FBSDKLoginManager?
    @IBOutlet weak var tfNome: UITextField!
    @IBOutlet weak var tfPassword: UITextField!
    let defaults = UserDefaults.standard
    @IBOutlet weak var entrar: UIButton!
    @IBOutlet weak var inscrever: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.hideKeyboardWhenTappedAround()
        visulaeffect.isHidden = true
        load.stopAnimating()
        logInFace = FBSDKLoginManager()
        logInFace?.logOut()
        //DAO.excluir()
        print(DAO.userSalvos(str: "name", entityName: "User"))
        print(DAO.userSalvos(str: "numberCard", entityName: "UserCard"))
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        myLayout.buttonLayout(objeto: [entrar, inscrever],color: UIColor.white,borderWidth: 1.2,corner: 0.1)
        layout.tfLayout(tf: [tfNome,tfPassword], image: nil)
        
        if let user = defaults.object(forKey: "entrar") as? Int{
            if user == 1 {
                performSegue(withIdentifier: "entrar", sender: self)
            }
        }
        
    }

//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "cadastrar" {
//            if let _ = FBSDKAccessToken.current() {
//                let viiewController:CriarContaViewController = segue.destination as! CriarContaViewController
//                viiewController.informacoes = self.informacoes
//            }
//            
//            
//        }
//    }
    override func viewWillAppear(_ animated: Bool) {
        print("will")
//        if let _ = FBSDKAccessToken.current() {
//            self.performSegue(withIdentifier: "cadastrar", sender: self)
//        }
    }
    
    @IBAction func esqueciSenha(_ sender: AnyObject) {
        
        performSegue(withIdentifier: "senha", sender: self)
//        let VC1 = self.storyboard!.instantiateViewController(withIdentifier: "senha") as! LembrarSenhaViewController
//        self.navigationController!.pushViewController(VC1, animated: true)
    }
    
    @IBAction func cadastrar(_ sender: AnyObject) {
        performSegue(withIdentifier: "cadastrar", sender: self)
    }
    
    
    @IBAction func entrar(_ sender: AnyObject) {
        visulaeffect.isHidden = false
        load.startAnimating()
        post()
        
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
                self.performSegue(withIdentifier: "cadastrar", sender: self)
            }
        }
    }
    
    
    func post() {
        
        print("entrou")
        let url = "http://testbed.tap4.com.br:3000/appLogin"
        let parameter: [String : Any] = ["email" : tfNome.text! , "password" : tfPassword.text!]
        
        Helper.POST(urlString: url, postString: parameter ) { (result) in
            self.verificarResult(result: result)
        }

    }
    
    func verificarResult(result: [String: Any]) {
        //print(result)
        let authorized = result["authorized"] as! Bool
        if authorized {
            if let user = result["user"] as? [String : Any] {
                print(user)
                DAO.separarPalavras(user: user)
                DispatchQueue.main.async {
                    self.load.stopAnimating()
                    self.visulaeffect.isHidden = true
                    self.defaults.set(1, forKey: "entrar")
                    self.performSegue(withIdentifier: "entrar", sender: self)
                }
                
            }
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
