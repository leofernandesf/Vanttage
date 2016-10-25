//
//  HomeViewController.swift
//  Vanttage
//
//  Created by leo on 26/09/16.
//  Copyright © 2016 tap4. All rights reserved.
//

import UIKit

protocol MostrarMapa {
    func mostrar(lat: Double, long: Double)
    
}

class HomeViewController: UIViewController {
    
    @IBOutlet weak var viewBusca: UIView!
    @IBOutlet weak var secondView: UIView!
    @IBOutlet weak var myTextField: UITextField!
    var companies : [Companies]?
    @IBOutlet weak var btBack: UIButton!
    
    @IBOutlet weak var muCollection: UICollectionView!
    @IBOutlet weak var table: UITableView!
    let menuSection = ["VANTAGENS", "MAPA"]
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dismissKeyboard()
        viewBusca.layer.cornerRadius = 5
        myTextField.delegate = self
        viewBusca.clipsToBounds = true
//        self.navigationController?.navigationBar.setBackgroundImage(#imageLiteral(resourceName: "header_scroll_bg"), for: .top, barMetrics: .default)
        self.table.tableFooterView = UIView(frame: .zero)
        let index = IndexPath(item: 0, section: 0)
        muCollection.selectItem(at: index, animated: true, scrollPosition: .left)
        
        if self.revealViewController() != nil {
            layout.acaoMenu(botao: btBack, vc: self)
        }
        GET()
    }
    
    
    func GET() {
        var request = URLRequest(url: URL(string: "http://vanttage.com.br:3000/api/Companies")!)
        request.httpMethod = "GET"
        //let postString = "id=12&name=teste"
        //request.httpBody = postString.data(using: .utf8)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {                                                 // check for fundamental networking error
                print("error=\(error)")
                return
            }
            
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print("response = \(response)")
            
            }else {
                
                print(data)
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
                    self.companies = [Companies]()
                    for dic in json as! [[String: AnyObject]]{
                        
                        let companie = Companies()
                        companie.nome = dic["name"] as? String
                        companie.phone = dic["phones"] as? String
                        companie.addres = dic["address"] as? String
                        //                    if let poin = dic["latlng"] as? String {
                        //                        var latlog = poin.components(separatedBy: ",")
                        //                        companie.lat = latlog[0]
                        //                        companie.long = latlog[1]
                        //                    }
                        companie.thumbnail = dic["thumbnail"] as? String
                        companie.banner1 = dic["bannerFeatured"] as? String
                        
                        self.companies?.append(companie)
                        
                        
                    }
                    
                    DispatchQueue.main.async {
                        self.table.reloadData()
                    }
                    
                    print(json)
                } catch let jsonError {
                    print(jsonError)
                }
            }
            
            
            
//            let responseString = String(data: data, encoding: .utf8)
//            print("responseString = \(responseString)")
        
            
        
        }
        task.resume()
    }
    
}

//MARK: - Extensions

extension HomeViewController : UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
}

extension HomeViewController: UITableViewDataSource {
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

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "informacao", sender: self)
    }
}

extension HomeViewController : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:MenuBarCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellMenu", for: indexPath) as! MenuBarCollectionViewCell
        cell.menuSection.text = menuSection[indexPath.row]
        //cell.backgroundColor = UIColor.red
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
}

extension HomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.item == 0 {
            self.secondView.isHidden = true
        } else {
            self.secondView.isHidden = false
            
        }
    }
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width/2, height: collectionView.bounds.height)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
}

extension HomeViewController: MostrarMapa {
    func mostrar(lat: Double, long: Double) {
        print(lat)
        print(long)
        self.secondView.isHidden = false
        self.muCollection.selectItem(at: IndexPath(item: 1, section: 0), animated: true, scrollPosition: .left)
    }
}
