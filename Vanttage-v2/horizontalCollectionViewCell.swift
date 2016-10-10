//
//  horizontalCollectionViewCell.swift
//  Vanttage-v2
//
//  Created by leo on 10/10/16.
//  Copyright © 2016 tap4. All rights reserved.
//

import UIKit

class horizontalCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var dias: UILabel!
    
    let layout1 = layout()
    override func awakeFromNib() {
        dias.layer.borderWidth = 2
        dias.layer.cornerRadius = 19
        dias.layer.borderColor = UIColor.lightGray.cgColor
    }
    
    override var isSelected: Bool {
        didSet {
            dias.layer.borderColor = isSelected ? UIColor.blue.laranja.cgColor : UIColor.lightGray.cgColor
            dias.textColor = isSelected ? UIColor.blue.laranja : UIColor.lightGray
        }
    }
    
    override var isHighlighted: Bool {
        didSet {
            dias.layer.borderColor = isHighlighted ? UIColor.blue.laranja.cgColor : UIColor.lightGray.cgColor
            dias.textColor = isHighlighted ? UIColor.blue.laranja : UIColor.lightGray
        }
    }
}
