//
//  testessssViewController.swift
//  Vanttage-v2
//
//  Created by leo on 17/10/16.
//  Copyright © 2016 tap4. All rights reserved.
//

import UIKit

class testessssViewController: UIViewController, UIDocumentInteractionControllerDelegate {

    @IBOutlet weak var myCollection: UICollectionView!
    @IBOutlet weak var scroll: UIScrollView!
    @IBOutlet weak var myTable: UITableView!
    let menuSection = ["Desconto","Regulamento","Local"]
    var documente: UIDocumentInteractionController!
    
    let screenHeight = UIScreen.main.bounds.height
    let scrollViewContentHeight = 1000 as CGFloat
    override func viewDidLoad() {
        super.viewDidLoad()
        myTable.tableFooterView = UIView(frame: .zero)
        let index = IndexPath(item: 0, section: 0)
        myCollection.selectItem(at: index, animated: true, scrollPosition: .left)
        
        scroll.contentSize.height = screenHeight + 220
        // myView.frame.height = screenHeight + 215
        
        scroll.delegate = self
        myTable.delegate = self
        scroll.bounces = false
        myTable.bounces = false
        myTable.isScrollEnabled = false
        print(scroll.contentSize)
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}


extension testessssViewController : UIScrollViewDelegate {
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
    
}


extension testessssViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: EstabelecimentoTableViewCell = tableView.dequeueReusableCell(withIdentifier: "cellEs", for: indexPath) as! EstabelecimentoTableViewCell
        let customView = UIView()
        customView.backgroundColor = UIColor.green.verde
        cell.selectedBackgroundView = customView
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
}

extension testessssViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellHeader")
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    
}


extension testessssViewController : UICollectionViewDataSource {
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

extension testessssViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}

extension testessssViewController: UICollectionViewDelegateFlowLayout {
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
