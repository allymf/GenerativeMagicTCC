//
//  Pixel.swift
//  Book_Sources
//
//  Created by Alysson Moreira on 21/03/19.
//

import Foundation

public struct Pixel {
    
    public typealias Position = Int
    public typealias Color = Float
    
    public var position: Position
    public var color: Color
    
    public init(at position: Position, with color: Color) {
        self.position = position
        self.color = color
    }
    
    
}

//public struct Color {
//    public var red: Double
//    public var green: Double
//    public var blue: Double
//
//    public init(red: Double, green: Double, blue: Double) {
//        self.red = red
//        self.green = green
//        self.blue = blue
//
//    }
//}
//
//public struct Position {
//    public var x: Int
//    public var y: Int
//
//    public init(x: Int, y: Int) {
//        self.x = x
//        self.y = y
//
//    }
//}
