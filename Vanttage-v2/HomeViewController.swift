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
    
    
    @IBOutlet weak var btFiltro: UIButton!
    
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
        let imagem = layout.sizeImage(width: 24, height: 24, image: #imageLiteral(resourceName: "menu_ic"))
        self.btBack.setImage(imagem, for: .normal)
        let imagem2 = layout.sizeImage(width: 24, height: 24, image: #imageLiteral(resourceName: "filter_ic"))
        self.btFiltro.setImage(imagem2, for: .normal)
        if self.revealViewController() != nil {
            layout.acaoMenu(botao: btBack, vc: self)
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        muCollection.delegate = self
        muCollection.dataSource = self
        print("entrou no didApear")
        viewBusca.layer.cornerRadius = 5
        myTextField.delegate = self
        viewBusca.clipsToBounds = true
        //        self.navigationController?.navigationBar.setBackgroundImage(#imageLiteral(resourceName: "header_scroll_bg"), for: .top, barMetrics: .default)
        let user = UserDefaults.standard
        print(user.object(forKey: "entrar"))
        GET()
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
        var request = URLRequest(url: URL(string: "http://testbed.tap4.com.br:3000/api/Companies/allCompanies?citiId=256")!)
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
                    print(json)
                    self.companies = [Companies]()
                    for dic in json as! [[String: AnyObject]]{
                        let company = dic["company"] as! [String : Any]
                        
                        let companie = Companies()
                        companie.nome = company["socialName"] as? String
                        companie.phone = company["phoneFix"] as? String
                        companie.addres = company["address"] as? String
                        companie.lat = company["lat"] as? String
                        companie.long = company["lon"] as? String
                        
                        companie.multiplyGold = company["multiply"] as? Int
                        companie.multiplyExclusive = company["multiply"] as? Int
                        companie.descricao = company["description"] as? String
                        companie.id = company["id"] as? Int
                        
                        
                        let companieImage = dic["companyImg"] as! [[String : Any]]
                        companie.comapniesImages = companieImage
                        
                        let promotions = dic["promotions"] as! [[String : Any]]
                        companie.promotions = promotions
                        self.companies?.append(companie)
                        
                        
                    }
                    
                    DispatchQueue.main.async {
                        self.displayCurrentTab(TabIndex.firstChildTab.rawValue)
                    }
                    
                    
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
        DispatchQueue.main.async {
            self.displayCurrentTab(indexPath.item)
        }
        
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

