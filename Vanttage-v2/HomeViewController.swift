//
//  HomeViewController.swift
//  Vanttage
//
//  Created by leo on 26/09/16.
//  Copyright © 2016 tap4. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var secondView: UIView!
    
    @IBOutlet weak var btBack: UIButton!
    
    @IBOutlet weak var muCollection: UICollectionView!
    @IBOutlet weak var table: UITableView!
    let menuSection = ["VANTAGENS", "MAPA"]
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.navigationController?.navigationBar.setBackgroundImage(#imageLiteral(resourceName: "header_scroll_bg"), for: .top, barMetrics: .default)
        self.table.tableFooterView = UIView(frame: .zero)
        let index = IndexPath(item: 0, section: 0)
        muCollection.selectItem(at: index, animated: true, scrollPosition: .left)
        
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
