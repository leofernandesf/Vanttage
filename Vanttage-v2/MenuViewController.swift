//
//  MenuViewController.swift
//  Vanttage-v2
//
//  Created by leo on 30/09/16.
//  Copyright © 2016 tap4. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {

    @IBOutlet weak var lbPontos: UILabel!
    @IBOutlet weak var lbNome: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        self.lbNome.text = DAO.userSalvos(str: "name", entityName: "User")
        // Do any additional setup after loading the view.
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
