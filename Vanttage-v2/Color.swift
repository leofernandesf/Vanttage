//
//  Color.swift
//  Vanttage
//
//  Created by leo on 22/09/16.
//  Copyright © 2016 tap4. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    
    var azul: UIColor {
        return HexToColor(hexString: "#49acff")
    }
    
    var verde: UIColor {
        return HexToColor(hexString: "#9bc540")
    }
    
    var laranja: UIColor {
        return HexToColor(hexString: "#d44c26")
    }
    
    
    func HexToColor(hexString: String, alpha:CGFloat? = 1.0) -> UIColor {
        // Convert hex string to an integer
        let hexint = Int(self.intFromHexString(hexStr: hexString))
        let red = CGFloat((hexint & 0xff0000) >> 16) / 255.0
        let green = CGFloat((hexint & 0xff00) >> 8) / 255.0
        let blue = CGFloat((hexint & 0xff) >> 0) / 255.0
        let alpha = alpha!
        // Create color object, specifying alpha as well
        let color = UIColor(red: red, green: green, blue: blue, alpha: alpha)
        return color
    }
    
    func intFromHexString(hexStr: String) -> UInt32 {
        var hexInt: UInt32 = 0
        // Create scanner
        let scanner: Scanner = Scanner(string: hexStr)
        // Tell scanner to skip the # character
        scanner.charactersToBeSkipped = NSCharacterSet(charactersIn: "#") as CharacterSet
        // Scan hex value
        scanner.scanHexInt32(&hexInt)
        return hexInt
    }
    
    class func imageWithColor(color: UIColor, size: CGSize = CGSize(width: 60, height: 60)) -> UIImage {
        let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height);        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        
        context!.setFillColor(color.cgColor);
        context!.fill(rect);
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext();
        
        return image!;
    }
}
