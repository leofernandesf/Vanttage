//
//  cell2TableViewCell.swift
//  Vanttage
//
//  Created by leo on 22/09/16.
//  Copyright © 2016 tap4. All rights reserved.
//

import UIKit

class cell2TableViewCell: UITableViewCell {
    
    @IBOutlet weak var ivImage: UIImageView!
    @IBOutlet weak var tfCartao: UITextField!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
