//
//  CartaoViewController.swift
//  Vanttage
//
//  Created by leo on 27/09/16.
//  Copyright © 2016 tap4. All rights reserved.
//

import UIKit

class CartaoViewController: UIViewController {
    
    @IBOutlet weak var btBack: UIButton!
    
    var cont = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if self.revealViewController() != nil {
            layout.acaoMenu(botao: btBack, vc: self)
        }
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//    @IBAction func acao(_ sender: AnyObject) {
//        //        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        //        let controller = storyboard.instantiateViewController(withIdentifier: "cartaoLandScape")
//        //        controller.willMove(toParentViewController: self)
//        //                   self.view.addSubview(controller.view)
//        //                    self.addChildViewController(controller)
//        //                    controller.didMove(toParentViewController: self)
//        //        if cont {
//        //            UIDevice.current.setValue(UIInterfaceOrientation.landscapeLeft.rawValue, forKey: "orientation")
//        //            //self.view.isHidden = true
//        //            cont = false
//        //        } else {
//        //            UIDevice.current.setValue(UIInterfaceOrientation.portrait.rawValue, forKey: "orientation")
//        //            cont = true
//        //        }
//        
//    }
//    override func willRotate(to toInterfaceOrientation: UIInterfaceOrientation, duration: TimeInterval) {
//        //let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        //        let controller = storyboard.instantiateViewController(withIdentifier: "cartaoLandScape")
//        //        if cont {
//        //            print("aqui")
//        //            controller.willMove(toParentViewController: self)
//        //            self.view.addSubview(controller.view)
//        //            self.addChildViewController(controller)
//        //            controller.didMove(toParentViewController: self)
//        //        } else {
//        //            print("aqui2")
//        //            controller.willMove(toParentViewController: nil)
//        //            controller.view.removeFromSuperview()
//        //            controller.removeFromParentViewController()
//        //        }
//        
//    }
    
    //    override func didRotate(from fromInterfaceOrientation: UIInterfaceOrientation) {
    //
    //    }
    
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
