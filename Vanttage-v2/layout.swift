//
//  layout.swift
//  Vanttage
//
//  Created by leo on 21/09/16.
//  Copyright © 2016 tap4. All rights reserved.
//

import Foundation
import UIKit

class layout {
    func buttonLayout(objeto:[UIButton], color: CGColor,borderWidth: CGFloat) {
        for button in objeto {
            button.layer.borderWidth = borderWidth
            button.layer.cornerRadius = 27
            button.clipsToBounds = true
            button.layer.borderColor = color
            button.setBackgroundImage(UIColor.imageWithColor(color: UIColor.darkGray), for: .highlighted)
        }
        
    }
    
    func imageLayout(image:UIImageView, recognizer: UITapGestureRecognizer?) {
        
        image.layer.cornerRadius = image.frame.width/2
        image.clipsToBounds = true
        image.layer.borderColor = UIColor.white.cgColor
        image.layer.borderWidth = 1
        
        if recognizer != nil {
            image.isUserInteractionEnabled = true
            image.addGestureRecognizer(recognizer!)
        }
        
    }
    
    static func acaoMenu(botao:UIButton, vc:UIViewController) {
        
        botao.addTarget(vc.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
        vc.view.addGestureRecognizer(vc.revealViewController().panGestureRecognizer())
        vc.revealViewController().rearViewRevealWidth = vc.view.frame.width - 80
    }
    
    static func tfLayout(tf:[UITextField], image:UIImage?) {
        for tfield in tf {
            let border = CALayer()
            let width = CGFloat(1.0)
            border.borderColor = UIColor.white.withAlphaComponent(0.6).cgColor
            border.frame = CGRect(x: 0, y: tfield.frame.size.height - width, width:  tfield.frame.size.width, height: tfield.frame.size.height)
            
            border.borderWidth = width
            tfield.layer.addSublayer(border)
            tfield.layer.masksToBounds = true
        }
        

//        let rect = CGRect(origin: CGPoint(x: 0,y :0), size: CGSize(width: 24, height: 24))
//        var envelopeView: UIImageView = UIImageView(frame: rect)
//        envelopeView.isUserInteractionEnabled = true
//        //envelopeView.addGestureRecognizer(recognizer)
//        envelopeView.image = #imageLiteral(resourceName: "user_ic")
//        envelopeView.contentMode = .scaleAspectFit
//        //recognizer.addTarget(revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)))
//        var viewLeft: UIView = UIView(frame: rect)
//        viewLeft.addSubview(envelopeView)
//        tfEmail.leftView?.frame = envelopeView.frame
//        tfEmail.leftView = viewLeft
//        tfEmail.leftViewMode = .always
    
    }
    
    static func titleLabel(viewTela: UIView, title: String, subtrair: CGFloat) -> UILabel{
        let titleLabel = UILabel(frame: CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: viewTela.frame.width - subtrair, height: viewTela.frame.height)))
        titleLabel.text = title
        titleLabel.textColor = UIColor.white
        titleLabel.font = UIFont.systemFont(ofSize: 25)
        return titleLabel
    }
}
