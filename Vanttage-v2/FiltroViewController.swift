//
//  FiltroViewController.swift
//  Vanttage-v2
//
//  Created by leo on 06/10/16.
//  Copyright © 2016 tap4. All rights reserved.
//

import UIKit

class FiltroViewController: UIViewController {

    @IBOutlet weak var myTable: UITableView!
    let headers: [String] = ["Ordenar por", "Dias da Semana", "Categorias"]
    let cellTitlles = ["Destaque", "Maior Desconto", "recente"]
    override func viewDidLoad() {
        super.viewDidLoad()
        myTable.tableFooterView = UIView(frame: .zero)
//        let pinImage = UIImage(named: "back_ic")
//        let size = CGSize(width: 24, height: 24)
//        UIGraphicsBeginImageContext(size)
//        pinImage!.draw(in: CGRect(x: 0, y: 0, width: 24, height: 24))
//        let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
//        UIGraphicsEndImageContext()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func back(_ sender: AnyObject) {
        _ = navigationController?.popViewController(animated: true)
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


extension FiltroViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 3
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        if indexPath.section == 0 {
            let customCell: FiltroTableViewCell = tableView.dequeueReusableCell(withIdentifier: "section1", for: indexPath) as! FiltroTableViewCell
            customCell.title.text = cellTitlles[indexPath.row]
            customCell.index = indexPath.row
            cell = customCell
        } else if indexPath.section == 1 {
            let customCell: FiltroSection2TableViewCell = tableView.dequeueReusableCell(withIdentifier: "section2", for: indexPath) as! FiltroSection2TableViewCell
            cell = customCell
        } else {
            let customCell: FiltroSection3TableViewCell = tableView.dequeueReusableCell(withIdentifier: "section3", for: indexPath) as! FiltroSection3TableViewCell
            cell = customCell
        }
        let viewCustom = UIView()
        viewCustom.backgroundColor = UIColor.clear
        cell.selectedBackgroundView = viewCustom
        return cell
    }
}

extension FiltroViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 50
        } else if indexPath.section == 1 {
            return 87
        } else {
            return 132
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell: HeaderFiltroTableViewCell = tableView.dequeueReusableCell(withIdentifier: "FiltroHeader") as! HeaderFiltroTableViewCell
        cell.name = headers[section]
        let border = CALayer()
        let width = CGFloat(1.0)
        border.borderColor = UIColor.lightGray.withAlphaComponent(0.3).cgColor
        border.frame = CGRect(x: 0, y: 0, width:  cell.frame.size.width, height: width)
        
        border.borderWidth = width
        cell.layer.addSublayer(border)
        cell.layer.masksToBounds = true
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
}
