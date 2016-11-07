//
//  HomeTableViewController.swift
//  Vanttage-v2
//
//  Created by leo on 27/10/16.
//  Copyright © 2016 tap4. All rights reserved.
//

import UIKit

class HomeTableViewController: UIViewController {
    @IBOutlet weak var table: UITableView!
    var companies: [Companies]?
    var companie: Companies?
    override func viewDidLoad() {
        super.viewDidLoad()
        

        // Do any additional setup after loading the view.
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print("entrou")
        DispatchQueue.main.async {
            self.table.delegate = self
            self.table.dataSource = self
            self.table.tableFooterView = UIView(frame: .zero)
        }
        
        
    }
    

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "informacao" {
            let vc: EstabelecimentoViewController = segue.destination as! EstabelecimentoViewController
            vc.estabelecimento = self.companie
            
        }
    }
 

}

extension HomeTableViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //var cell1 = tableView.dequeueReusableCell(withIdentifier: "cellHome", for: indexPath) as? UITableViewCell
        //if cell1 == nil {
        let  cell1 = tableView.dequeueReusableCell(withIdentifier: "cellHome") as! HomeTableViewCell
        //cell1.mostrar = self
        cell1.companie = self.companies?[indexPath.row]
        //}
        
        //        cell.layer.cornerRadius = 10
        //        cell.clipsToBounds = true
        print("cell: ",cell1)
        return cell1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return companies?.count ?? 0
    }
    
    
}

extension HomeTableViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.companie = companies?[indexPath.row]

        performSegue(withIdentifier: "informacao", sender: self)
        self.table.deselectRow(at: indexPath, animated: true)
    }
}
