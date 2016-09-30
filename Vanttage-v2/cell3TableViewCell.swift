//
//  cell3TableViewCell.swift
//  Vanttage
//
//  Created by leo on 22/09/16.
//  Copyright © 2016 tap4. All rights reserved.
//

import UIKit

class cell3TableViewCell: UITableViewCell {
    
    @IBOutlet weak var limparCampos: UIButton!
    @IBOutlet weak var confirmar: UIButton!
    
    var atualizar: Atualizar!
    let myLayout = layout()
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        myLayout.buttonLayout(objeto: [limparCampos, confirmar], color: UIColor.white.laranja.cgColor, borderWidth: 1.2)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    @IBAction func limparCampos(_ sender: AnyObject) {
        atualizar.limparTable()
    }
    
    @IBAction func confirmar(_ sender: AnyObject) {
        atualizar.mostrar()
    }
    
}
