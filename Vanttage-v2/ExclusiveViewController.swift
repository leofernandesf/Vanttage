//
//  ExclusiveViewController.swift
//  Vanttage-v2
//
//  Created by leo on 03/11/16.
//  Copyright © 2016 tap4. All rights reserved.
//

import UIKit

class ExclusiveViewController: UIViewController {
    let myLayout = layout()
    @IBOutlet weak var btVoltar: UIButton!
    
    @IBOutlet weak var nextView: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        let image = layout.sizeImage(width: 18, height: 18, image: #imageLiteral(resourceName: "back_ic"))
//        btVoltar.setImage(image, for: .normal)
        
        self.navigationController?.navigationBar.isHidden = true
        layout.acaoMenu(botao: btVoltar, vc: self)
        myLayout.buttonLayout(objeto: [nextView], color: UIColor.red.laranja, borderWidth: 1.2, corner: 0.1)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    @IBAction func voltaer(_ sender: AnyObject) {
        print("vai")
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
