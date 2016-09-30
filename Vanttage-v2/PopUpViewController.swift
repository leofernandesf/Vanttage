//
//  PopUpViewController.swift
//  Vanttage
//
//  Created by leo on 23/09/16.
//  Copyright © 2016 tap4. All rights reserved.
//

import UIKit

class PopUpViewController: UIViewController {
    
    let myLayout = layout()
    
    
    @IBOutlet weak var btBack: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("foi")
        myLayout.buttonLayout(objeto: [btBack], color: UIColor.white.cgColor, borderWidth: 1)
        //
        // Do any additional setup after loading the view.
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func voltar(_ sender: AnyObject) {
        self.willMove(toParentViewController: nil)
        self.view.removeFromSuperview()
        self.removeFromParentViewController()
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
