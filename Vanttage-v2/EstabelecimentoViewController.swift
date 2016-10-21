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
    
    @IBOutlet weak var myCollection: UICollectionView!
    @IBOutlet weak var scroll: UIScrollView!
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var imageScrollView: UIScrollView!
    
    @IBOutlet weak var pageControll: UIPageControl!
    var local: Locais?
    
    
    let images = [#imageLiteral(resourceName: "pin_ic"),#imageLiteral(resourceName: "cartao_gold"), #imageLiteral(resourceName: "map_ic"), #imageLiteral(resourceName: "header_scroll_bg")]
    var currentViewController: UIViewController?
    lazy var firstChildTabVC: UIViewController? = {
        let firstChildTabVC: PromocoesViewController = self.storyboard?.instantiateViewController(withIdentifier: "descontoViewController") as! PromocoesViewController
        firstChildTabVC.verificador = true
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
        let index = IndexPath(item: 0, section: 0)
        myCollection.selectItem(at: index, animated: true, scrollPosition: .left)
        
        scroll.contentSize.height = screenHeight + 220
        // myView.frame.height = screenHeight + 215
        
        scroll.delegate = self
        scroll.bounces = false
        print(scroll.contentSize)
        
        displayCurrentTab(TabIndex.firstChildTab.rawValue)
        imagem()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if let currentViewController = currentViewController {
            currentViewController.viewWillDisappear(animated)
        }
    }
    
    @IBAction func compartilhar(_ sender: AnyObject) {
        
        print("share")
        let imageDta = UIImagePNGRepresentation(UIImage(named: "pin_ic")!)
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
            vc = firstChildTabVC
        case TabIndex.secondChildTab.rawValue :
            vc = secondChildTabVC
        case TabIndex.thirdChildTab.rawValue :
            vc = thirdChildTabVC
        default:
            return nil
        }
        
        return vc
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
    
    func imagem() {
        self.pageControll.numberOfPages = images.count
        let scrollViewWidth:CGFloat = self.imageScrollView.frame.width
        let scrollViewHeight:CGFloat = self.imageScrollView.frame.height
        
        
        for i in 0..<images.count {
            let novaImagem = UIImageView(frame: CGRect(x: scrollViewWidth*CGFloat(i), y: 0, width: scrollViewWidth, height: scrollViewHeight))
            novaImagem.image = images[i]
            //novaImagem.contentMode = .scaleAspectFit
            //novaImagem.contentMode = .scaleAspectFill
            novaImagem.contentMode = .scaleToFill
            self.imageScrollView.addSubview(novaImagem)
        }
        
        self.imageScrollView.contentSize = CGSize(width: scrollViewWidth * CGFloat(images.count), height: scrollViewHeight)
        self.imageScrollView.delegate = self
        self.pageControll.currentPage = 0
    }
    
    
}


extension EstabelecimentoViewController : UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let yOffset = scrollView.contentOffset.y
        print(yOffset)
        //        if scrollView == self.scroll {
        //            if yOffset >= 194.0 {
        //                self.scroll.isScrollEnabled = false
        //                myTable.isScrollEnabled = true
        //            }
        //            //            if yOffset >= scrollViewContentHeight - screenHeight {
        //            //                scrollView.isScrollEnabled = false
        //            //                mttable.isScrollEnabled = true
        //            //            }
        //        }
        //
        //        if scrollView == self.myTable {
        //            if yOffset <= 0 {
        //                self.scroll.isScrollEnabled = true
        //                self.myTable.isScrollEnabled = false
        //            }
        //        }
        //
        //        if yOffset >= scrollViewContentHeight - screenHeight {
        //            scrollView.isScrollEnabled = false
        //            myTable.isScrollEnabled = true
        //        }
    }
    
    //    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
    //        print("vai 1")
    //    }
    //
    //    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
    //        print("vai 2")
    //    }
    //
    //    func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
    //        print("vai 3")
    //    }
    //    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
    //        print("vai 4")
    //    }
    //
    //    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
    //        print("vai 5")
    //    }
    //
    //    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
    //        print("vai 6")
    //    }
    
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
