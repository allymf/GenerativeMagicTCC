//
//  UIColor+InitFromHex.swift
//  Book_Sources
//
//  Created by Alysson Moreira on 20/03/19.
//

import UIKit

extension UIColor {
    
    convenience init(_ hex: UInt32 ) {
        
        //        let mask = 0x000000FF
        //        let r = CGFloat(Float(Int(hex >> 16) & mask)/255.0)
        //        let g = CGFloat(Float(Int(hex >> 8) & mask)/255.0)
        //        let b = CGFloat(Float(Int(hex) & mask)/255.0)
        //
        //        self.init(displayP3Red: r, green: g, blue: b, alpha: 1.0)
        //
        var blue = Float(((hex >> 16) & 0xFF))
        blue /= 255.0
        var green = Float(((hex >> 8) & 0xFF))
        green /= 255.0
        
        var red = Float(((hex) & 0xFF))
        red /= 255.0
        
        
        self.init(displayP3Red: CGFloat(red), green: CGFloat(green), blue: CGFloat(blue), alpha: 1.0)
        
    }
    
}
