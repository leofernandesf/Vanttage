//
//  HeaderFiltroTableViewCell.swift
//  Vanttage-v2
//
//  Created by leo on 10/10/16.
//  Copyright © 2016 tap4. All rights reserved.
//

import UIKit

class HeaderFiltroTableViewCell: UITableViewCell {

    @IBOutlet weak var title: UILabel!
    
    var name = "" {
        didSet {
            self.backgroundColor = UIColor.white
            title.text = name
        }
    }

}
