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
        Cadastro.verErro(nometf: tfNome.text, passwordtf: tfPassword.text) { (result, id) in
            DispatchQueue.main.async {
                self.load.stopAnimating()
                self.visulaeffect.isHidden = true
                if result == true {
                    self.defaults.set(1, forKey: "entrar")
                    //self.defaults.set(id, forKey: "tipoCartao")
                    self.performSegue(withIdentifier: "entrar", sender: self)
                } else {
                    print("nao pode entrar")
                }
                
            }
            
        }
//        var nome: String!
//        var password: String!
//        
//        if let email = tfNome.text {
//            nome = email
//        }
//        
//        if let senha = tfPassword.text {
//            password = senha
//        }
//        let params: Dictionary<String, Any> = ["email": nome, "password": password]
//        var request = URLRequest(url: URL(string: "http://vanttage.com.br:3000/appLogin")!)
//        request.httpMethod = "POST"
//        do {
//            let json = try JSONSerialization.data(withJSONObject: params, options: [])
//            request.httpBody = json
//        } catch let jsonError {
//            print(jsonError)
//        }
//        
//        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
//        request.addValue("application/json", forHTTPHeaderField: "Accept")
//        
//        let task = URLSession.shared.dataTask(with: request) { data, response, error in
//            guard let data = data, error == nil else {                                                 // check for fundamental networking error
//                print("error=\(error)")
//                return
//            }
//            
//            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
//                print("statusCode should be 200, but is \(httpStatus.statusCode)")
//                print("response = \(response)")
//                
//            } else {
//                let responseString = String(data: data, encoding: .utf8)
//                print("responseString = \(responseString)")
//                DispatchQueue.main.async {
//                    self.performSegue(withIdentifier: "entrar", sender: self)
//                }
//                
//            }
//        }
//        task.resume()
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
