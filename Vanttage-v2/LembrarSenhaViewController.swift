//
//  LembrarSenhaViewController.swift
//  Vanttage
//
//  Created by leo on 21/09/16.
//  Copyright © 2016 tap4. All rights reserved.
//

import UIKit

class LembrarSenhaViewController: UIViewController {
    let mylayout = layout()
    
    @IBOutlet weak var tfEmail: UITextField!
    
    @IBOutlet weak var enviar: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        print(enviar.frame.width)
        mylayout.buttonLayout(objeto: [enviar], color: UIColor.white,borderWidth: 1.2,corner: 0.1)
        self.hideKeyboardWhenTappedAround()
        layout.tfLayout(tf: [tfEmail], image: nil)
        // Do any additional setup after loading the view.
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func back(_ sender: AnyObject) {
        _ = navigationController?.popViewController(animated: true)
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
