//
//  BotaoTableViewCell.swift
//  Vanttage-v2
//
//  Created by leo on 23/11/16.
//  Copyright © 2016 tap4. All rights reserved.
//

import UIKit

class BotaoTableViewCell: UITableViewCell {

    @IBOutlet weak var btSolicitar: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        btSolicitar.layer.cornerRadius = 25
        btSolicitar.setBackgroundImage(UIColor.imageWithColor(color: UIColor.black.withAlphaComponent(0.5)), for: .highlighted)
        btSolicitar.clipsToBounds = true
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func solicitar(_ sender: Any) {
        print("Clicou")
    }

}
