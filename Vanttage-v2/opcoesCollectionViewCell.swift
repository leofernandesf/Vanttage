//
//  opcoesCollectionViewCell.swift
//  Vanttage-v2
//
//  Created by leo on 05/10/16.
//  Copyright © 2016 tap4. All rights reserved.
//

import UIKit

class opcoesCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var lbSection: UILabel!
    @IBOutlet weak var imageSelected: UIImageView!
    
    override var isSelected: Bool {
        didSet{
            lbSection.textColor = isSelected ? UIColor.white : UIColor.white.withAlphaComponent(0.6)
            imageSelected.isHidden = isSelected ? false : true
        }
    }
    
    override var isHighlighted: Bool {
        didSet{
            lbSection.textColor = isHighlighted ? UIColor.white : UIColor.white.withAlphaComponent(0.6)
            imageSelected.isHidden = isHighlighted ? false : true
        }
    }
    
}
