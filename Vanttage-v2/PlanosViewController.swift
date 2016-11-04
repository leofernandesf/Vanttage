//
//  PlanosViewController.swift
//  Vanttage-v2
//
//  Created by leo on 03/11/16.
//  Copyright © 2016 tap4. All rights reserved.
//

import UIKit

class PlanosViewController: UIViewController {

    @IBOutlet weak var myCollection: UICollectionView!
    @IBOutlet weak var btAvancar: UIButton!
    let myLayout = layout()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myLayout.buttonLayout(objeto: [btAvancar], color: UIColor.blue.azulEscuro, borderWidth: 1.2, corner: 0.1)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.myCollection.delegate = self
        self.myCollection.dataSource = self
    }
    
    @IBAction func voltar(_ sender: AnyObject) {
        _ = self.navigationController?.popViewController(animated: true)
    }

    @IBAction func avancar(_ sender: AnyObject) {
        performSegue(withIdentifier: "cartaoExclusive", sender: self)
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

extension PlanosViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: PlanoCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellPlano", for: indexPath) as!PlanoCollectionViewCell
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
}

extension PlanosViewController: UICollectionViewDelegate {
    
//    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
//        let layout = self.myCollection.collectionViewLayout as! UICollectionViewFlowLayout
//        let cellWidth = layout.itemSize.width + layout.minimumLineSpacing
//        
//        var offset = targetContentOffset.pointee
//        let index = (offset.x + scrollView.contentInset.left)/cellWidth
//        
//        let roundedInex = round(index)
//        
//        offset = CGPoint(x: roundedInex * cellWidth - scrollView.contentInset.left, y: -scrollView.contentInset.top)
//        targetContentOffset.pointee = offset
//    }
    
}
