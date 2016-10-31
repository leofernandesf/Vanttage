//
//  testessssViewController.swift
//  Vanttage-v2
//
//  Created by leo on 17/10/16.
//  Copyright © 2016 tap4. All rights reserved.
//

import UIKit

class EstabelecimentoViewController: UIViewController, UIDocumentInteractionControllerDelegate {
    
    enum TabIndex : Int {
        case firstChildTab = 0
        case secondChildTab = 1
        case thirdChildTab = 2
    }
    
    @IBOutlet weak var lnTopNome: UILabel!
    @IBOutlet weak var lbNome: UILabel!
    @IBOutlet weak var myCollection: UICollectionView!
    @IBOutlet weak var scroll: UIScrollView!
    
    @IBOutlet weak var tvDescrecao: UITextView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var imageScrollView: UIScrollView!
    
    @IBOutlet weak var pageControll: UIPageControl!
    //var local: Locais?
    var estabelecimento: Companies!
    var images: [UIImage]?
    var currentViewController: UIViewController?
    var promocoes : [Promocoes]?
    
    
    
    lazy var firstChildTabVC: UIViewController? = {
        let firstChildTabVC = self.storyboard?.instantiateViewController(withIdentifier: "descontoViewController")
        return firstChildTabVC
    }()
    
    lazy var secondChildTabVC : UIViewController? = {
        let secondChildTabVC = self.storyboard?.instantiateViewController(withIdentifier: "regulamentoViewControllerId")
        return secondChildTabVC
    }()
    
    lazy var thirdChildTabVC : UIViewController? = {
        let thirdChildTabVC = self.storyboard?.instantiateViewController(withIdentifier: "localViewController")
        return thirdChildTabVC
    }()
    
    let menuSection = ["Desconto","Regulamento","Local"]
    var documente: UIDocumentInteractionController!
    
    let screenHeight = UIScreen.main.bounds.height
    let scrollViewContentHeight = 1000 as CGFloat
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
        print(images?.count)
        let index = IndexPath(item: 0, section: 0)
        myCollection.selectItem(at: index, animated: true, scrollPosition: .left)
        
        getImages()
        // myView.frame.height = screenHeight + 215
        
        scroll.delegate = self
        scroll.bounces = false
        
        setUpPromocoes()
        //displayCurrentTab(TabIndex.firstChildTab.rawValue)
        imagem()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        scroll.contentSize.height = screenHeight + 220
        print(scroll.contentSize)
    }
    
    func getImages() {
        let image = UIImageView()
        
        if let url1 = estabelecimento.banner1 {
            print(url1)
            if url1 != "banner1" {
                image.loadImageUsingURL(urlString: "http://vanttage.com.br:3000/\(url1)", completion: { (imagem) in
                    self.images = [imagem]
                    self.imagem()
                    
                    if let url2 = self.estabelecimento.banner2 {
                        if url2 != "banner2" {
                            image.loadImageUsingURL(urlString: "http://vanttage.com.br:3000/\(url2)", completion: { (imagem) in
                                self.images?.append(image.image!)
                                self.imagem()
                                
                                if let url3 = self.estabelecimento.banner3 {
                                    if url3 != "banner3" {
                                        image.loadImageUsingURL(urlString: "http://vanttage.com.br:3000/\(url3)", completion: { (imagem) in
                                            self.images?.append(image.image!)
                                            self.imagem()
                                            
                                            if let url4 = self.estabelecimento.banerFeatured {
                                                if url4 != "undifined" {
                                                    image.loadImageUsingURL(urlString: "http://vanttage.com.br:3000/\(url4)", completion: { (imagem) in
                                                        self.images?.append(image.image!)
                                                        self.imagem()
                                                    })
                                                }
                                            }
                                        })
                                    }
                                }
                            })
                        }
                    }
                })
            }
        }
        
        
        
        
        
        
        
        //image.lo
    }
    
    func x() {
        
    }
    
    func setView() {
        if let nome = estabelecimento.nome {
            self.lbNome.text = nome
            self.lnTopNome.text = nome
        }
        
        if let descricao = estabelecimento.descricao {
            self.tvDescrecao.text = descricao
        }
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if let currentViewController = currentViewController {
            currentViewController.viewWillDisappear(animated)
        }
    }
    
    
    func setUpPromocoes() {
        if let ID = self.estabelecimento.id {
            print(ID)
            var request = URLRequest(url: URL(string: "http://vanttage.com.br:3000/api/Companies/\(ID)/promotions")!)
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
                        self.promocoes = [Promocoes]()
                        for dic in json as! [[String: AnyObject]]{
                            
                            let promocao = Promocoes()
                            promocao.id = dic["id"] as! Int?
                            promocao.isFeatured = dic["isFeatured"] as! Int?
                            promocao.descricao = dic["description"] as! String?
                            promocao.value = dic["value"] as! String?
                            promocao.discount = dic["discount"] as! String?
                            promocao.howToUse = dic["howToUse"] as! String?
                            promocao.rules = dic["rules"] as! String?
                            promocao.status = dic["status"] as! Int?
                            promocao.dayStart = dic["dayStart"] as! Int?
                            promocao.dayEnd = dic["dayEnd"] as! Int?
                            promocao.startHour = dic["startHour"] as! String?
                            promocao.endHour = dic["endHour"] as! String?
                            promocao.citiesId = dic["citiesId"] as! Int?
                            promocao.companiesId = dic["companiesId"] as! Int?
                            self.promocoes?.append(promocao)
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
        
    }
    
    @IBAction func compartilhar(_ sender: AnyObject) {
        
        print("share")
        let imageDta = UIImagePNGRepresentation((images?[0])!)
        let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent("test.jpg")
        do {
            try imageDta?.write(to: fileURL, options: .atomic)
        } catch {
            print(error)
        }
        
        self.documente = UIDocumentInteractionController(url: fileURL)
        self.documente.delegate = self
        DispatchQueue.main.async {
            self.documente.presentOpenInMenu(from: self.view.frame, in: self.view, animated: true)
        }
    }
    
    
    
    @IBAction func back(_ sender: AnyObject) {
        self.images = []
        _ = self.navigationController?.popViewController(animated: true)
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
            let vc1: PromocoesViewController = firstChildTabVC as! PromocoesViewController
            vc1.promocoes = self.promocoes
            vc = vc1
        case TabIndex.secondChildTab.rawValue :
            let vc2: RegulamentoViewController = secondChildTabVC as! RegulamentoViewController
            vc2.promocao = self.promocoes
            vc = vc2
        case TabIndex.thirdChildTab.rawValue :
            let vc3: LocalViewController = thirdChildTabVC as! LocalViewController
            vc3.local = self.estabelecimento
            vc = vc3
        default:
            return nil
        }
        
        return vc
    }
    
    
    func imagem() {
        print(images)
        if images != nil {
            print("entrou")
            self.pageControll.numberOfPages = (images?.count)!
            let scrollViewWidth:CGFloat = self.imageScrollView.frame.width
            let scrollViewHeight:CGFloat = self.imageScrollView.frame.height
            
            let x = images?.count
            for i in 0..<x! {
                let novaImagem = UIImageView(frame: CGRect(x: scrollViewWidth*CGFloat(i), y: 0, width: scrollViewWidth, height: scrollViewHeight))
                novaImagem.image = images?[i]
                //novaImagem.contentMode = .scaleAspectFit
                //novaImagem.contentMode = .scaleAspectFill
                novaImagem.contentMode = .scaleToFill
                self.imageScrollView.addSubview(novaImagem)
            }
            
            self.imageScrollView.contentSize = CGSize(width: scrollViewWidth * CGFloat((images?.count)!), height: scrollViewHeight)
            self.imageScrollView.delegate = self
            self.pageControll.currentPage = 0
        }
        
    }
    
    
}



extension EstabelecimentoViewController : UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let yOffset = scrollView.contentOffset.y
        print(yOffset)
                //if scrollView == self.scroll {
        if yOffset >= 160.0 {
            self.lbNome.isHidden = true
            self.tvDescrecao.isHidden = true
            self.lnTopNome.isHidden = false
                //    }
                    //            if yOffset >= scrollViewContentHeight - screenHeight {
                    //                scrollView.isScrollEnabled = false
                    //                mttable.isScrollEnabled = true
                    //            }
        } else {
            self.lbNome.isHidden = false
            self.tvDescrecao.isHidden = false
            self.lnTopNome.isHidden = true
        }
        
//                if yOffset >= scrollViewContentHeight - screenHeight {
//                    scrollView.isScrollEnabled = false
//                    myTable.isScrollEnabled = true
//                }
    }
    
//        func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
//            print("vai 1")
//        }
    
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageWidth:CGFloat = scrollView.frame.width
        let currentPage:CGFloat = floor((scrollView.contentOffset.x-pageWidth/2)/pageWidth)+1
        // Change the indicator
        self.pageControll.currentPage = Int(currentPage);
        // Change the text accordingly
    }
    
}


extension EstabelecimentoViewController : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:opcoesCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "opcao", for: indexPath) as! opcoesCollectionViewCell
        cell.lbSection.text = menuSection[indexPath.row]
        //cell.backgroundColor = UIColor.red
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
}

extension EstabelecimentoViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.currentViewController?.view.removeFromSuperview()
        self.currentViewController?.removeFromParentViewController()
        displayCurrentTab(indexPath.item)
    }
}

extension EstabelecimentoViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width/3, height: collectionView.bounds.height)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
}

