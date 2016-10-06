//
//  cell1TableViewCell.swift
//  Vanttage-v2
//
//  Created by leo on 30/09/16.
//  Copyright © 2016 tap4. All rights reserved.
//

import UIKit

class cell1TableViewCell: UITableViewCell {

    @IBOutlet weak var ivImage: UIImageView!
    @IBOutlet weak var tfText: UITextField!
    @IBOutlet weak var lbFrase: UILabel!
    var index: Int!
    var informacao: Cadastro? {
        didSet {
            switch index {
            case 0:
                if let nome = informacao?.nome {
                    tfText.text = nome
                }

                break
            case 2:
                if let email = informacao?.email {
                    tfText.text = email
                }
                break
            default:
                return
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
