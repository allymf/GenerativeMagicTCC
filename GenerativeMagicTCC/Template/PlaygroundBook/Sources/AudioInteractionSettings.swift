//
//  AudioInteractionSettings.swift
//  Book_Sources
//
//  Created by Alysson Moreira on 17/11/19.
//

import Foundation
import CoreGraphics
import UIKit

public class AudioInteractionSettings: NSObject, NSCoding {

//    public var mode: DrawMode = .text
//    public var shape: ShapeType = .circle
//    public var font: Font = .futura
    public var minimumSize: Double = 30.0
    public var maximumSize: Double = 80.0
    public var initialColor: UIColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    public var highestColor: UIColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)


    public init(minimumSize: Double, maximumSize: Double, initialColor: UIColor, highestColor: UIColor) {
        self.minimumSize = minimumSize
        self.maximumSize = maximumSize
        self.initialColor = initialColor
        self.highestColor = highestColor
    }

    enum CodingKeys: String, CodingKey {
        case minimumSize
        case maximumSize
        case initialColor
        case highestColor
    }

    public func encode(with aCoder: NSCoder) {
        aCoder.encode(initialColor, forKey: CodingKeys.initialColor.rawValue)
        aCoder.encode(highestColor, forKey: CodingKeys.highestColor.rawValue)

        aCoder.encode(minimumSize, forKey: CodingKeys.minimumSize.rawValue)
        aCoder.encode(maximumSize, forKey: CodingKeys.maximumSize.rawValue)
    }

    required convenience public init?(coder aDecoder: NSCoder) {

        let initialColor = aDecoder.decodeObject(forKey: CodingKeys.initialColor.rawValue) as? UIColor ?? UIColor.white

        let highestColor = aDecoder.decodeObject(forKey: CodingKeys.highestColor.rawValue) as? UIColor ?? UIColor.white

        let minimumSize = aDecoder.decodeDouble(forKey: CodingKeys.minimumSize.rawValue)
        let maximumSize = aDecoder.decodeDouble(forKey: CodingKeys.maximumSize.rawValue)

        self.init(minimumSize: minimumSize, maximumSize: maximumSize, initialColor: initialColor, highestColor: highestColor)

    }

}
