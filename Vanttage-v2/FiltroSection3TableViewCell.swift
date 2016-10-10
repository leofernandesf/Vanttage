//
//  FiltroSection3TableViewCell.swift
//  Vanttage-v2
//
//  Created by leo on 10/10/16.
//  Copyright © 2016 tap4. All rights reserved.
//

import UIKit

class FiltroSection3TableViewCell: UITableViewCell {

    @IBOutlet weak var btGastronomia: UIButton!
    @IBOutlet weak var btEntreterimento: UIButton!
    @IBOutlet weak var btBeleza: UIButton!
    @IBOutlet weak var btservico: UIButton!
    
    var verificador1 = true
    var verificador2 = true
    var verificador3 = true
    var verificador4 = true
    
    
    var color = UIColor()
    let myLayout = layout()
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        myLayout.buttonLayout(objeto: [btGastronomia,btEntreterimento,btBeleza,btservico], color: UIColor.lightGray, borderWidth: 2,corner: 22)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    @IBAction func gastronomia(_ sender: AnyObject) {
        print("gastronomia")
        if verificador1 {
            color = UIColor.black.laranja
            verificador1 = false
        } else {
            color = UIColor.lightGray
            verificador1 = true
        }
        self.btGastronomia.layer.borderColor = color.cgColor
        self.btGastronomia.setTitleColor(color, for: .normal)
    }
    @IBAction func entreterimento(_ sender: AnyObject) {
        print("entreterimento")
        if verificador2 {
            color = UIColor.black.laranja
            verificador2 = false
        } else {
            color = UIColor.lightGray
            verificador2 = true
        }
        self.btEntreterimento.layer.borderColor = color.cgColor
        self.btEntreterimento.setTitleColor(color, for: .normal)
    }
    @IBAction func beleza(_ sender: AnyObject) {
        print("beleza")
        if verificador3 {
            color = UIColor.black.laranja
            verificador3 = false
        } else {
            color = UIColor.lightGray
            verificador3 = true
        }
        self.btBeleza.layer.borderColor = color.cgColor
        self.btBeleza.setTitleColor(color, for: .normal)
    }
    @IBAction func servico(_ sender: AnyObject) {
        print("servico")
        if verificador4 {
            color = UIColor.black.laranja
            verificador4 = false
        } else {
            color = UIColor.lightGray
            verificador4 = true
        }
        self.btservico.layer.borderColor = color.cgColor
        self.btservico.setTitleColor(color, for: .normal)
    }
    
    

}
