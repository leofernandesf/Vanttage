//
//  CartaoViewController.swift
//  Vanttage
//
//  Created by leo on 27/09/16.
//  Copyright © 2016 tap4. All rights reserved.
//

import UIKit

class CartaoViewController: UIViewController {
    
    @IBOutlet weak var lbNome: UILabel!
    @IBOutlet weak var btBack: UIButton!
    @IBOutlet weak var lbData: UILabel!
    @IBOutlet weak var lbN1: UILabel!
    @IBOutlet weak var lbAdesao: UILabel!
    
    var cont = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let titleLabel = layout.titleLabel(viewTela: view, title: "Cartao Virtual", subtrair: 150)
        self.navigationItem.titleView = titleLabel
        if self.revealViewController() != nil {
            layout.acaoMenu(botao: btBack, vc: self)
        }
        
        lbNome.text = DAO.userSalvos(str: "name", entityName: "User")
        lbN1.text = DAO.userSalvos(str: "numberCard", entityName: "UserCard")
        
        
        let str = DAO.userSalvos(str: "createdAt", entityName: "UserCard")
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        let date = dateFormatter.date(from: str)!
        dateFormatter.dateFormat = "dd/MM/yy"
        let dateString = dateFormatter.string(from: date)
        self.lbData.text = dateString
        // Do any additional setup after loading the view.
    }

    
    
//    func separarNumeros() {
//        let numberCard = DAO.userSalvos(str: "numberCard", entityName: "UserCard")
//        let ch = Array(numberCard.characters)
//        print(ch.count)
//        lbN1.text = "\(ch[0])\(ch[1])\(ch[2])\(ch[3])"
//        lbN2.text = "\(ch[4])\(ch[5])\(ch[6])\(ch[7])"
//        lbN3.text = "\(ch[8])\(ch[9])\(ch[10])\(ch[11])"
//        //lbN4.text = "\(ch[12])\(ch[13])\(ch[14])\(ch[15])"
//    }
    
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


extension CartaoViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellCartao")
        cell?.textLabel?.text = "blalbalbal"
        return cell!
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        if section == 1 {
//            return "% Ultimos Descontos"
//        } else {
//            return ""
//        }
//    }
}

extension CartaoViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 50
        
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellCartao")!
        cell.backgroundColor = UIColor.white
        cell.textLabel?.text = "% Ultimos Descontos"
        
       
        return cell
    }
}
