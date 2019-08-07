//
//  CanvasSettings.swift
//  Book_Sources
//
//  Created by Alysson Moreira on 20/03/19.
//

import Foundation
import CoreGraphics

public class CanvasSettings: NSObject, NSCoding {
    
    public var mode: DrawMode = .text
    public var shape: ShapeType = .circle
    public var font: Font = .futura
    public var size: Double = 20.0
    public var step: Double = 0.02
    public var text: String = "WWDC"
    
    
    public init(mode: DrawMode, shape: ShapeType = .circle, font: Font = .chalck, size: Double, step: Double, text: String = "WWDC") {
        self.mode = mode
        self.shape = shape
        self.font = font
        self.size = size
        self.step = step
        self.text = text
    }
    
    enum CodingKeys: String, CodingKey {
        case mode
        case shape
        case font
        case size
        case step
        case text
    }
    
    public func encode(with aCoder: NSCoder) {
        aCoder.encode(mode.rawValue, forKey: CodingKeys.mode.rawValue)
        
        aCoder.encode(shape.rawValue, forKey: CodingKeys.shape.rawValue)
        
        aCoder.encode(font.rawValue, forKey: CodingKeys.font.rawValue)
        
        aCoder.encode(size, forKey: CodingKeys.size.rawValue)
        aCoder.encode(step, forKey: CodingKeys.step.rawValue)
        aCoder.encode(text, forKey: CodingKeys.text.rawValue)
    }
    
    required convenience public init?(coder aDecoder: NSCoder) {
        
        let mode = DrawMode(rawValue: aDecoder.decodeInteger(forKey: CodingKeys.mode.rawValue)) ?? DrawMode.shape
        
        let shape = ShapeType(rawValue: aDecoder.decodeInteger(forKey: CodingKeys.shape.rawValue)) ?? ShapeType.circle
        
        let font = Font(rawValue: aDecoder.decodeObject(forKey: CodingKeys.font.rawValue) as? String ?? "Futura-Bold") ?? Font.futura
        
         let size = aDecoder.decodeDouble(forKey: CodingKeys.size.rawValue)
        let text = aDecoder.decodeObject(of: NSString.self, forKey: CodingKeys.text.rawValue) as String? ?? ""
        let step = aDecoder.decodeDouble(forKey: CodingKeys.step.rawValue)

        //self.init(font: font, size: size, step: step, text: text)
        self.init(mode: mode, shape: shape, font: font, size: size, step: step, text: text)
        
    }
    
    
    
    
    
    
    
    
    
    
//    init(data: NSData) {
//        let coding = NSKeyedUnarchiver.unarchiveObjectWithData(data) as! Coding
//        name = coding.name as String
//        date = coding.date
//    }
//
//    func asData() -> NSData {
//        return NSKeyedArchiver.archivedDataWithRootObject(Coding(self))
//    }
    
//    func encode(to encoder: Encoder) throws {
//        var container = encoder.container(keyedBy: CodingKeys.self)
//        try container.encode(font.rawValue, forKey: .font)
//        try container.encode(size, forKey: .size)
//        try container.encode(step, forKey: .step)
//        try container.encode(text, forKey: .text)
//    }
//
//    init(from decoder: Decoder) throws {
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//        font = Font(rawValue: try values.decode(String.self, forKey: .font))!
//        size = try values.decode(CGFloat.self, forKey: .size)
//        step = try values.decode(Double.self, forKey: .step)
//        text = try values.decode(String.self, forKey: .text)
//    }
}
