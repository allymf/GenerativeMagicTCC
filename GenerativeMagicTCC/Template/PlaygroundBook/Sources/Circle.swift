//
//  Circle.swift
//  AudioDemo
//
//  Created by Alysson Moreira on 16/11/19.
//  Copyright © 2019 Alysson Moreira. All rights reserved.
//

import Foundation
import CoreGraphics

public struct Circle {
    
    public let start: CGFloat = -CGFloat.pi * 0.5
    public let end = CGFloat.pi * 2.0 + (-CGFloat.pi * 0.5)
    
    public var color: CGColor
    public var radius: CGFloat
    public var center: CGPoint
    
    public init(color: CGColor, radius: CGFloat, center: CGPoint) {
        self.color = color
        self.radius = radius
        self.center = center
    }
    
    
}
