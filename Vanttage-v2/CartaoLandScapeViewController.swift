//
//  CartaoLandScapeViewController.swift
//  Vanttage
//
//  Created by leo on 29/09/16.
//  Copyright © 2016 tap4. All rights reserved.
//

import UIKit

class CartaoLandScapeViewController: UIViewController {
    
    @IBOutlet weak var lbNome: UILabel!
    @IBOutlet weak var lbData: UILabel!
    @IBOutlet weak var lbN: UILabel!
    @IBOutlet weak var btVoltar: UIButton!
    let appdelegate = UIApplication.shared.delegate as! AppDelegate
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let image = layout.sizeImage(width: 32, height: 26, image: #imageLiteral(resourceName: "Change_view_ic"))
        btVoltar.setImage(image, for: .normal)
        
        lbNome.text = DAO.userSalvos(str: "name", entityName: "User")
        lbN.text = DAO.userSalvos(str: "numberCard", entityName: "UserCard")
        
        let str = DAO.userSalvos(str: "createdAt", entityName: "UserCard")
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        let date = dateFormatter.date(from: str)!
        dateFormatter.dateFormat = "dd/MM/yy"
        let dateString = dateFormatter.string(from: date)
        self.lbData.text = dateString
        // Do any additional setup after loading the view.
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        print(btVoltar.frame.size.width)
        print(btVoltar.frame.width)
        let appdelegate = UIApplication.shared.delegate as! AppDelegate
        appdelegate.shouldSupportAllOrientation = true
        UIDevice.current.setValue(UIInterfaceOrientation.landscapeLeft.rawValue, forKey: "orientation")
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func voltar(_ sender: AnyObject) {
        appdelegate.shouldSupportAllOrientation = false
        dismiss(animated: false, completion: nil)
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
