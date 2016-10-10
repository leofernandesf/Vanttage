//
//  FiltroSection2TableViewCell.swift
//  Vanttage-v2
//
//  Created by leo on 10/10/16.
//  Copyright © 2016 tap4. All rights reserved.
//

import UIKit

class FiltroSection2TableViewCell: UITableViewCell {
    
    
    let dias = ["Todos os dias", "Segunda", "Terca", "Quarta", "Quinta", "Sexta", "Sabado", "Domingo"]
    @IBOutlet weak var myCollection: UICollectionView!
    override func awakeFromNib() {
        super.awakeFromNib()
        let index = IndexPath(item: 0, section: 0)
        myCollection.selectItem(at: index, animated: true, scrollPosition: .left)
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

extension FiltroSection2TableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:horizontalCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellHorizontal", for: indexPath) as! horizontalCollectionViewCell
        cell.dias.text = dias[indexPath.item]
        return cell
    }
}

func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
    let itemsPerRow:CGFloat = 4
    let hardCodedPadding:CGFloat = 5
    let itemWidth = (collectionView.bounds.width / itemsPerRow) - hardCodedPadding
    let itemHeight = collectionView.bounds.height - (2 * hardCodedPadding)
    return CGSize(width: itemWidth, height: itemHeight)
}
