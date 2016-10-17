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
    func buttonLayout(objeto:[UIButton], color: UIColor,borderWidth: CGFloat, corner: CGFloat) {
        for button in objeto {
            button.layer.borderWidth = borderWidth
            button.layer.cornerRadius = corner
            button.clipsToBounds = true
            button.layer.borderColor = color.cgColor
            button.setBackgroundImage(UIColor.imageWithColor(color: color.withAlphaComponent(0.5)), for: .highlighted)
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
    
    static func sizeImage(width: CGFloat, height: CGFloat, image: UIImage) -> UIImage{
        let pinImage = image
        let size = CGSize(width: width , height: height)
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        pinImage.draw(in: CGRect(x: 0, y: 0, width: width, height: height))
        let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return resizedImage!
    }
    
    static func titleLabel(viewTela: UIView, title: String, subtrair: CGFloat) -> UILabel{
        let titleLabel = UILabel(frame: CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: viewTela.frame.width - subtrair, height: viewTela.frame.height)))
        titleLabel.text = title
        titleLabel.textColor = UIColor.white
        titleLabel.font = UIFont.systemFont(ofSize: 25)
        return titleLabel
    }
}


extension UIView {
    func showAnimation(view:UIView) {
        view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        view.alpha = 0.0
        UIView.animate(withDuration: 0.25) { 
            view.alpha = 1.0
            view.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        }
    }
    
    func removeAnimate(view: UIView) {
        UIView.animate(withDuration: 0.25, animations: {
            view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
            view.alpha = 0.0
            }, completion: { (finished: Bool) in
                if finished {
                    view.removeFromSuperview()
                }
        })
    }
}
