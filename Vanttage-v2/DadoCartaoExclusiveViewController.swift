//
//  DadoCartaoExclusiveViewController.swift
//  Vanttage-v2
//
//  Created by leo on 03/11/16.
//  Copyright © 2016 tap4. All rights reserved.
//

import UIKit

class DadoCartaoExclusiveViewController: UIViewController {

    @IBOutlet weak var btConfirmar: UIButton!
    let myLayout = layout()
    override func viewDidLoad() {
        super.viewDidLoad()
        myLayout.buttonLayout(objeto: [btConfirmar], color: UIColor.blue.azulEscuro, borderWidth: 1.2, corner: 0.1)
        self.dismissKeyboard()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func voltar(_ sender: AnyObject) {
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
