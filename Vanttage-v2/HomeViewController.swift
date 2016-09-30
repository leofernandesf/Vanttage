//
//  HomeViewController.swift
//  Vanttage
//
//  Created by leo on 26/09/16.
//  Copyright © 2016 tap4. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    
    @IBOutlet weak var btBack: UIButton!
    
    @IBOutlet weak var table: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.setBackgroundImage(#imageLiteral(resourceName: "header_scroll_bg"), for: .top, barMetrics: .default)
        self.table.tableFooterView = UIView(frame: .zero)
        
        
        if self.revealViewController() != nil {
            layout.acaoMenu(botao: btBack, vc: self)
        }
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

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:HomeTableViewCell = tableView.dequeueReusableCell(withIdentifier: "cellHome") as! HomeTableViewCell
        //        cell.layer.cornerRadius = 10
        //        cell.clipsToBounds = true
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
}

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("foi")
    }
}
