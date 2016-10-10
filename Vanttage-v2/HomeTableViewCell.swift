//
//  HomeTableViewCell.swift
//  Vanttage
//
//  Created by leo on 27/09/16.
//  Copyright © 2016 tap4. All rights reserved.
//

import UIKit

class HomeTableViewCell: UITableViewCell {
    
    @IBOutlet weak var imageBackgorund: UIImageView!
    @IBOutlet weak var imageProfile: UIImageView!
    @IBOutlet weak var btLayout: UIButton!
    
    let myLayout = layout()
    override func awakeFromNib() {
        super.awakeFromNib()
        myLayout.imageLayout(image: imageProfile, recognizer: nil)
        imageBackgorund.clipsToBounds = true
        imageBackgorund.layer.cornerRadius = 5
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    @IBAction func click(_ sender: AnyObject) {
        self.btLayout.backgroundColor = isHighlighted ? UIColor.gray : UIColor.blue
    }
    
//    override func prepareForReuse() {
//        super.prepareForReuse()
//        self.btLayout.backgroundColor = UIColor.clear
//    }
    
}
