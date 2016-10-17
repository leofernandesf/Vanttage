//
//  HomeTableViewCell.swift
//  Vanttage
//
//  Created by leo on 27/09/16.
//  Copyright © 2016 tap4. All rights reserved.
//

import UIKit

class HomeTableViewCell: UITableViewCell {
    
    var mostrar: MostrarMapa?
    @IBOutlet weak var imageBackgorund: UIImageView!
    @IBOutlet weak var imageProfile: UIImageView!
    @IBOutlet weak var btLayout: UIButton!
    let latitude3 = -3.135774 as Double
    let longitude3 = -60.021162 as Double
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
        mostrar?.mostrar(lat: latitude3, long: longitude3)
    }
    
//    override func prepareForReuse() {
//        super.prepareForReuse()
//        self.btLayout.backgroundColor = UIColor.clear
//    }
    
}
