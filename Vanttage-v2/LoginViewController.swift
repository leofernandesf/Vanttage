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
    @IBOutlet weak var tfNome: UITextField!
    @IBOutlet weak var tfPassword: UITextField!
    
    @IBOutlet weak var entrar: UIButton!
    @IBOutlet weak var inscrever: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myLayout.buttonLayout(objeto: [entrar, inscrever],color: UIColor.white,borderWidth: 1.2,corner: 0.1)
        self.hideKeyboardWhenTappedAround()
        layout.tfLayout(tf: [tfNome,tfPassword], image: nil)
        logInFace = FBSDKLoginManager()
        logInFace?.logOut()
        
        
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
