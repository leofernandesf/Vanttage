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
        myLayout.buttonLayout(objeto: [entrar, inscrever],color: UIColor.white.cgColor,borderWidth: 1.2)
        self.hideKeyboardWhenTappedAround()
        layout.tfLayout(tf: [tfNome,tfPassword], image: nil)
        logInFace = FBSDKLoginManager()
        
        //logInFace?.logOut()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(_ animated: Bool) {
        print("will")
        if let token = FBSDKAccessToken.current() {
            self.graphRequest()
        }
    }
    
    @IBAction func esqueciSenha(_ sender: AnyObject) {
        let VC1 = self.storyboard!.instantiateViewController(withIdentifier: "senha") as! LembrarSenhaViewController
        self.navigationController!.pushViewController(VC1, animated: true)
    }
    @IBAction func logarFacebook(_ sender: AnyObject) {
        print("clicou")
        
        logInFace?.logIn(withReadPermissions: ["email"], from: self) { (result, error) in
            if (error != nil) {
                print("Erro em logar",error?.localizedDescription)
            } else if (result?.isCancelled)! {
                print("CANCELADO")
            } else {
                print("logado")
            }
        }
    }
    
    func graphRequest() {
        
        FBSDKGraphRequest(graphPath: "me", parameters: ["fields":"id,email,name,picture.type(large)"]).start { (connection, result, error) in
            if error != nil {
                print(error)
                return
            }
            let data:[String:AnyObject] = result as! [String : AnyObject]
            if let email = data["email"] as? String {
                print(email)
            }
            
            if data["picture"] != nil {
                let pic = data["picture"] as! NSDictionary
                let data = pic["data"] as! NSDictionary
                let url = data["url"] as! String
                
                if let url = NSURL(string: url), let data = NSData(contentsOf: url as URL), let downloadedImage = UIImage(data: data as Data) {
                    print(downloadedImage)
                }
            }
            
            
        }
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
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
