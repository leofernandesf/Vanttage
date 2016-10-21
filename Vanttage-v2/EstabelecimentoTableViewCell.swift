//
//  EstabelecimentoTableViewCell.swift
//  Vanttage-v2
//
//  Created by leo on 05/10/16.
//  Copyright © 2016 tap4. All rights reserved.
//

import UIKit

class EstabelecimentoTableViewCell: UITableViewCell {
    @IBOutlet weak var lbPorcentagem: UILabel!
    @IBOutlet weak var lbDescricao: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        self.lbPorcentagem.textColor = isSelected ? UIColor.white : UIColor.black
        self.lbDescricao.textColor = isSelected ? UIColor.white : UIColor.black
    }
    
//    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
//        super.setHighlighted(highlighted, animated: animated)
//        
//        self.lbPorcentagem.textColor = highlighted ? UIColor.white : UIColor.black
//        self.lbDescricao.textColor = highlighted ? UIColor.white : UIColor.black
//    }
    

}
