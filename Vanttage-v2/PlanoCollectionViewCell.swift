//
//  PlanoCollectionViewCell.swift
//  Vanttage-v2
//
//  Created by leo on 03/11/16.
//  Copyright © 2016 tap4. All rights reserved.
//

import UIKit

class PlanoCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var selectedImage: UIView!
    @IBOutlet weak var lbReais: UILabel!
    @IBOutlet weak var lbCentavos: UILabel!
    @IBOutlet weak var tvDescricao: UITextView!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.layer.cornerRadius = 10.0
        self.clipsToBounds = true
    }
    
    override var isSelected: Bool {
        didSet{
            selectedImage.isHidden = isSelected ? false : true
        }
    }
}
