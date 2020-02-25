//
//  CanvasView.swift
//  AudioDemo
//
//  Created by Alysson Moreira on 16/11/19.
//  Copyright © 2019 Alysson Moreira. All rights reserved.
//

import Foundation
import UIKit

public class CanvasView: UIView {
    
    public var circles = [Circle]()
    
    public var strokeColor: CGColor = UIColor.black.cgColor {
        didSet {
            setNeedsDisplay()
        }
    }
    
    public var circleRadius: CGFloat = 4.0 {
        didSet {
            setNeedsDisplay()
        }
    }
    
    //Debug
    //var delegate: CanvasDifferDelegate?
    
    override public func draw(_ rect: CGRect) {
        super.draw(rect)
        
        guard let context = UIGraphicsGetCurrentContext() else { return }


        self.circles.forEach { (circle) in
            context.setFillColor(circle.color)
            context.move(to: circle.center)

            context.addArc(center: circle.center, radius: circle.radius, startAngle: circle.start, endAngle: circle.end, clockwise: false)

            context.fillPath()
        }
        
        
    }
    
    override public func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let point = touches.first?.location(in: self) else {return}

        self.circles.append(Circle(color: self.strokeColor, radius: self.circleRadius, center: point))
        //Debug
        //self.delegate?.circles(self.circles.count)
        setNeedsDisplay()
    }
    
    override public func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let point = touches.first?.location(in: self) else { return }

        self.circles.append(Circle(color: self.strokeColor, radius: self.circleRadius, center: point))
        
        //Debug
        //self.delegate?.circles(self.circles.count)
        setNeedsDisplay()
    }
    
    public func undo() {
        _ = self.circles.popLast()
        setNeedsDisplay()
    }
    
    public func clear() {
        self.circles.removeAll()
        setNeedsDisplay()
    }
    
}

// Debug Only
//protocol CanvasDifferDelegate: class {
//    func circles(_ numbers: Int)
//}
