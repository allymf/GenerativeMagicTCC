//
//  CanvasDelegate.swift
//  Book_Sources
//
//  Created by Alysson Moreira on 20/03/19.
//

import UIKit

protocol CanvasDelegate {
    
    func setupWith(fontName: String, fontSize: CGFloat ) -> Void
    func setupWith(diameter: CGFloat ) -> Void
    
    func backgroundWith(_ color: UIColor) -> Void
    
    func displayText(_ text: String, with color: UIColor) -> Void
    
    func displayShapeOf(_ type: ShapeType, with color: UIColor)
    
    func resetCanvas()
    
    func displayFeedBack(text: String) -> Void 
    
}
