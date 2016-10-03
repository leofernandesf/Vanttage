//
//  SobreViewController.swift
//  Vanttage
//
//  Created by leo on 26/09/16.
//  Copyright © 2016 tap4. All rights reserved.
//

import UIKit

class SobreViewController: UIViewController {
    
    
    @IBOutlet weak var btBack: UIButton!
    
    let recognizer = UITapGestureRecognizer()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let titleLabel = layout.titleLabel(viewTela: self.view, title: "Sobre", subtrair: 90)
        self.navigationItem.titleView = titleLabel
        if self.revealViewController() != nil {
            layout.acaoMenu(botao: btBack, vc: self)
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
