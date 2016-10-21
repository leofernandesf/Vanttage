//
//  HomeTableViewCell.swift
//  Vanttage
//
//  Created by leo on 27/09/16.
//  Copyright © 2016 tap4. All rights reserved.
//

import UIKit

class HomeTableViewCell: UITableViewCell {
    
    
    
    @IBOutlet weak var backGround: UIView!
    @IBOutlet weak var nome: UILabel!
    @IBOutlet weak var lbFone: UILabel!
    @IBOutlet weak var lbEndereco: UILabel!
    @IBOutlet weak var thumbImage: UIImageView!
    //var mostrar: MostrarMapa?
    @IBOutlet weak var imageProfile: UIImageView!
    @IBOutlet weak var btLayout: UIButton!
    let latitude3 = -3.135774 as Double
    let longitude3 = -60.021162 as Double
    
    
    
    var companie: Companies? {
        didSet {
            self.nome.text = companie?.nome
            self.lbFone.text = companie?.phone
            self.lbEndereco.text = companie?.addres
            print(companie?.thumbnail)
            print(companie?.long)
            print(companie?.lat)
            //self.imageProfile.image = UIImage(named: (companie?.thumbnail)!)
        }
    }
    
    
    
    let myLayout = layout()
    override func awakeFromNib() {
        super.awakeFromNib()
        myLayout.imageLayout(image: imageProfile, recognizer: nil)
        backGround.layer.masksToBounds = true
        backGround.clipsToBounds = true
        backGround.layer.cornerRadius = 5
        backGround.layer.shadowOffset = CGSize.zero
        backGround.layer.shadowColor = UIColor.black.cgColor
        backGround.layer.shadowRadius = 5.0
        backGround.layer.shadowOpacity = 0.3
        backGround.layer.masksToBounds = false
        
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    @IBAction func click(_ sender: AnyObject) {
        //mostrar?.mostrar(lat: latitude3, long: longitude3)
    }
    
//    override func prepareForReuse() {
//        super.prepareForReuse()
//        self.btLayout.backgroundColor = UIColor.clear
//    }
    
}
