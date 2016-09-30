//
//  EditarPerfilViewController.swift
//  Vanttage
//
//  Created by leo on 28/09/16.
//  Copyright © 2016 tap4. All rights reserved.
//

import UIKit

class EditarPerfilViewController: UIViewController {
    
    @IBOutlet weak var btBack: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layout.acaoMenu(botao: btBack, vc: self)
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("teste")
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
