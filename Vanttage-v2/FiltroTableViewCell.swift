//
//  FiltroTableViewCell.swift
//  Vanttage-v2
//
//  Created by leo on 10/10/16.
//  Copyright © 2016 tap4. All rights reserved.
//

import UIKit

class FiltroTableViewCell: UITableViewCell {
    let imagem = [#imageLiteral(resourceName: "star_ic"), #imageLiteral(resourceName: "discount_ic"), #imageLiteral(resourceName: "time_ic")]
    let imageSelected = [#imageLiteral(resourceName: "star_agora_ic"), #imageLiteral(resourceName: "discount_selected_ic"), #imageLiteral(resourceName: "time_selected_ic")]
    @IBOutlet weak var selectImage: UIImageView!
    
    @IBOutlet weak var title: UILabel!
    var index: Int?
    var name = "" {
        didSet {
            self.title.text = name
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if let i = index {
            self.selectImage.image = selected ? imageSelected[i] : imagem[i]
            self.title.textColor = selected ? UIColor.lightGray.laranja : UIColor.gray
        }
        
        // Configure the view for the selected state
    }
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        super.setHighlighted(highlighted, animated: animated)
        if let i = index {
            self.selectImage.image = highlighted ? imageSelected[i] : imagem[i]
            self.title.textColor = highlighted ? UIColor.lightGray.laranja : UIColor.gray
        }
    }
    
}
