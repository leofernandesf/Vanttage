//
//  PopUpOKViewController.swift
//  Vanttage-v2
//
//  Created by leo on 17/10/16.
//  Copyright © 2016 tap4. All rights reserved.
//

import UIKit

class PopUpOKViewController: UIViewController {

    @IBOutlet weak var popUpview: UIView!
    @IBOutlet weak var btOK: UIButton!
    let myLayout = layout()
    let defaults = UserDefaults.standard
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.popUpview.layer.cornerRadius = 5
        myLayout.buttonLayout(objeto: [btOK], color: UIColor.white, borderWidth: 1,corner: 0.1)
        self.view.showAnimation(view: self.view)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func entrar(_ sender: AnyObject) {
        
        self.view.removeAnimate(view: self.view)
        self.defaults.set(1, forKey: "entrar")
        self.defaults.set(1, forKey: "tipoCartao")
        _ = self.navigationController?.popViewController(animated: true)
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
