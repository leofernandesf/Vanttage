//
//  EstabelecimentoViewController.swift
//  Vanttage-v2
//
//  Created by leo on 04/10/16.
//  Copyright © 2016 tap4. All rights reserved.
//

import UIKit

class EstabelecimentoViewController: UIViewController, UIDocumentInteractionControllerDelegate {
    
    @IBOutlet weak var myCollection: UICollectionView!

    let menuSection = ["Desconto","Regulamento","Local"]
    var documente: UIDocumentInteractionController!
    override func viewDidLoad() {
        super.viewDidLoad()
        //
        // Do any additional setup after loading the view.
        let index = IndexPath(item: 0, section: 0)
        myCollection.selectItem(at: index, animated: true, scrollPosition: .left)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func back(_ sender: AnyObject) {
        self.navigationController?.popViewController(animated: true)
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
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}


extension EstabelecimentoViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: EstabelecimentoTableViewCell = tableView.dequeueReusableCell(withIdentifier: "cellEs", for: indexPath) as! EstabelecimentoTableViewCell
        let customView = UIView()
        customView.backgroundColor = UIColor.green
        cell.selectedBackgroundView = customView
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
}

extension EstabelecimentoViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellHeader") 
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
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
