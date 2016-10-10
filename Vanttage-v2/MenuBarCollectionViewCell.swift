//
//  MenuBarCollectionViewCell.swift
//  Vanttage-v2
//
//  Created by leo on 04/10/16.
//  Copyright © 2016 tap4. All rights reserved.
//

import UIKit

class MenuBarCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var menuSection: UILabel!
    @IBOutlet weak var imageSelected: UIImageView!
    
    override var isSelected: Bool {
        didSet{
            menuSection.textColor = isSelected ? UIColor.white : UIColor.white.withAlphaComponent(0.6)
            imageSelected.isHidden = isSelected ? false : true
        }
    }

    override var isHighlighted: Bool {
        didSet{
            menuSection.textColor = isHighlighted ? UIColor.white : UIColor.white.withAlphaComponent(0.6)
            imageSelected.isHidden = isHighlighted ? false : true
        }
    }
    
}
