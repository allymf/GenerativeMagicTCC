//
//  UIColor+Interpolate.swift
//  AudioDemo
//
//  Created by Alysson Moreira on 17/11/19.
//  Copyright © 2019 Alysson Moreira. All rights reserved.
//

import UIKit

extension UIColor {
    
    public static func getIntermidiateFrom(_ initialColor: UIColor, to finalColor: UIColor, by factor: CGFloat) -> UIColor {
        
        let f = min(max(0, factor), 1)
        
        guard let initialCP = initialColor.cgColor.components else { fatalError("Unexpected nil color") }
        guard let finalCP = finalColor.cgColor.components else { fatalError("Unexpected nil color") }
        
        let newRed = CGFloat(initialCP[0] + (finalCP[0] - initialCP[0]) * f)
        let newGreen = CGFloat(initialCP[1] + (finalCP[1] - initialCP[1]) * f)
        let newBlue  = CGFloat(initialCP[2] + (finalCP[2] - initialCP[2]) * f)
        
        let newAlpha  = CGFloat(initialCP[3] + (finalCP[3] - initialCP[3]) * f)
        
        return UIColor(displayP3Red: newRed, green: newGreen, blue: newBlue, alpha: newAlpha)
    }
    
    public static func getIntermediateHue(from initialColor: UIColor, to highestColor: UIColor, by factor: CGFloat) -> UIColor {
        
        let f = min(max(0, factor), 1)
        
        var h1: CGFloat = 0
        var s1: CGFloat = 0
        var v1: CGFloat = 0
        var a1: CGFloat = 0
        
        var h2: CGFloat = 0
        var s2: CGFloat = 0
        var v2: CGFloat = 0
        var a2: CGFloat = 0
        
        initialColor.getHue(&h1, saturation: &s1, brightness: &v1, alpha: &a1)
        highestColor.getHue(&h2, saturation: &s2, brightness: &v2, alpha: &a2)
        
        let h: CGFloat = h1 + (h2 - h1) * f;
        let s: CGFloat = s1 + (s2 - s1) * f;
        let v: CGFloat = v1 + (v2 - v1) * f;
        let a: CGFloat = a1 + (a2 - a1) * f;

        return UIColor(hue: h, saturation: s, brightness: v, alpha: a)
        
    }
    
    public func getTranslucent() -> UIColor {
        guard let cp = self.cgColor.components else { fatalError("Unexpected nil color") }
        
        let red = cp[0]
        let green = cp[1]
        let blue  = cp[2]
        
        let newAlpha = CGFloat(0.5)
        
        return UIColor(displayP3Red: red, green: green, blue: blue, alpha: newAlpha)
    }
    
}
