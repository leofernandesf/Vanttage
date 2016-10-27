//
//  TablejViewController.swift
//  Vanttage-v2
//
//  Created by leo on 18/10/16.
//  Copyright © 2016 tap4. All rights reserved.
//

import UIKit

class PromocoesViewController: UIViewController {

    
    @IBOutlet weak var myTable: UITableView!
    var verificador = false
    var promocoes: [Promocoes]?
    override func viewDidLoad() {
        super.viewDidLoad()
        print(verificador)
        myTable.tableFooterView = UIView(frame: .zero)
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

extension PromocoesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: EstabelecimentoTableViewCell = tableView.dequeueReusableCell(withIdentifier: "cellEs", for: indexPath) as! EstabelecimentoTableViewCell
        let customView = UIView()
        customView.backgroundColor = UIColor.green.verde
        cell.selectedBackgroundView = customView
        
        cell.promocao = self.promocoes?[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return promocoes?.count ?? 0
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
}

extension PromocoesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellHeader")
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    
}
