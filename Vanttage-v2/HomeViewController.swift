//
//  HomeViewController.swift
//  Vanttage
//
//  Created by leo on 26/09/16.
//  Copyright © 2016 tap4. All rights reserved.
//

import UIKit


class HomeViewController: UIViewController {
    enum TabIndex : Int {
        case firstChildTab = 0
        case secondChildTab = 1
    }
    
    @IBOutlet weak var viewBusca: UIView!
    @IBOutlet weak var myTextField: UITextField!
    var companies : [Companies]?
    var companei: Companies?
    var image: UIImage?
    @IBOutlet weak var btBack: UIButton!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var muCollection: UICollectionView!
    var currentViewController: UIViewController?
    let menuSection = ["VANTAGENS", "MAPA"]
    
    lazy var firstChildTabVC: UIViewController? = {
        let firstChildTabVC = self.storyboard?.instantiateViewController(withIdentifier: "vc1")
        return firstChildTabVC
    }()
    
    lazy var secondChildTabVC : UIViewController? = {
        let secondChildTabVC = self.storyboard?.instantiateViewController(withIdentifier: "map")
        return secondChildTabVC
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dismissKeyboard()
        
        if self.revealViewController() != nil {
            layout.acaoMenu(botao: btBack, vc: self)
        }
        GET()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        muCollection.delegate = self
        muCollection.dataSource = self
        
        viewBusca.layer.cornerRadius = 5
        myTextField.delegate = self
        viewBusca.clipsToBounds = true
        //        self.navigationController?.navigationBar.setBackgroundImage(#imageLiteral(resourceName: "header_scroll_bg"), for: .top, barMetrics: .default)
        
        let index = IndexPath(item: 0, section: 0)
        muCollection.selectItem(at: index, animated: true, scrollPosition: .left)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if let currentViewController = currentViewController {
            currentViewController.viewWillDisappear(animated)
        }
    }
    
    func GET() {
        var request = URLRequest(url: URL(string: "http://vanttage.com.br:3000/api/Companies/allCompanie?citiId=256")!)
        request.httpMethod = "GET"

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {                                                 // check for fundamental networking error
                print("error=\(error)")
                return
            }
            
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print("response = \(response)")
            
            }else {
                
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
                    self.companies = [Companies]()
                    for dic in json as! [[String: AnyObject]]{
                        
                        let companie = Companies()
                        companie.nome = dic["name"] as? String
                        companie.phone = dic["phones"] as? String
                        companie.addres = dic["address"] as? String
                        if let poin = dic["latlng"] as? String {
                            if poin != "" {
                                print(poin)
                                var latlog = poin.components(separatedBy: ",")
                                companie.lat = latlog[0]
                                companie.long = latlog[1]
                            }

                        }
                        companie.descricao = dic["description"] as? String
                        companie.id = dic["id"] as? Int
                        companie.thumbnail = dic["thumbnail"] as? String
                        companie.banner1 = dic["bannerFeatured"] as? String
                        companie.banner2 = dic["banner1"] as? String
                        companie.banner3 = dic["banner2"] as? String
                        companie.banerFeatured = dic["banner3"] as? String
                        self.companies?.append(companie)
                        
                        
                    }
                    
                    DispatchQueue.main.async {
                        self.displayCurrentTab(TabIndex.firstChildTab.rawValue)
                    }
                    
                    print(json)
                } catch let jsonError {
                    print(jsonError)
                }
            }

        }
        task.resume()
    }
    
    
    func displayCurrentTab(_ tabIndex: Int){
        if let vc = viewControllerForSelectedSegmentIndex(tabIndex) {
            
            self.addChildViewController(vc)
            vc.didMove(toParentViewController: self)
            
            vc.view.frame = self.contentView.bounds
            self.contentView.addSubview(vc.view)
            self.currentViewController = vc
        }
    }
    
    
    
    
    func viewControllerForSelectedSegmentIndex(_ index: Int) -> UIViewController? {
        var vc: UIViewController?
        switch index {
        case TabIndex.firstChildTab.rawValue :
            let vc1: HomeTableViewController = firstChildTabVC as! HomeTableViewController
            vc1.companies = self.companies
            vc = vc1
        case TabIndex.secondChildTab.rawValue :
            let vc2: MapViewController = secondChildTabVC as! MapViewController
            vc2.companies = self.companies
            vc = vc2
        default:
            return nil
        }
        
        return vc
    }
    
}

//MARK: - Extensions

extension HomeViewController : UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
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
        self.currentViewController?.view.removeFromSuperview()
        self.currentViewController?.removeFromParentViewController()
        displayCurrentTab(indexPath.item)
    }
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width/2, height: collectionView.frame.size.height)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
}

