//
//  CanvasSKScene.swift
//  Book_Sources
//
//  Created by Alysson Moreira on 20/03/19.
//


import SpriteKit

class CanvasSKScene: SKScene {
    
    var x: CGFloat = 0
    var y: CGFloat = 0
    
    var shapesize: CGFloat = 10
    var fontSize: CGFloat = 40
    var fontName: String = "Chalkduster"
    
    var selectNode = SKLabelNode()
    
    var nodes = [SKNode]()
    
    public override func didMove(to: SKView) {
        self.selectNode = SKLabelNode(text: "Select an Image")
        self.selectNode.fontSize = 30
        if #available(iOS 11.0, *) {
            self.selectNode.numberOfLines = 45
        }
        self.selectNode.fontColor = .white
        self.selectNode.fontName = "Futura-Bold"
        self.selectNode.verticalAlignmentMode = .center
        self.selectNode.horizontalAlignmentMode = .center
        self.selectNode.position = CGPoint(x: self.frame.width/2, y: self.frame.height/2)

        self.addChild(self.selectNode)

        
    }
    
    public override func update(_ currentTime: TimeInterval) {
        
        
    }
    
    
}

extension CanvasSKScene: CanvasDelegate {
    func displayFeedBack(text: String) {
        self.selectNode.text = text
    }
    
    func resetCanvas() {
        self.x = 0
        self.y = self.frame.height
        
        self.removeAllChildren()
        self.nodes = [SKNode]()
        
        self.addChild(self.selectNode)
    }
    
    func backgroundWith(_ color: UIColor){
        self.scene?.backgroundColor = color
    }
    
    func setupWith(diameter: CGFloat) {
        self.shapesize = diameter
    }
    
    func setupWith(fontName: String, fontSize: CGFloat) {
        self.fontSize = fontSize
        self.fontName = fontName
        
        //        self.x = fontSize/1.5
        //        self.y = self.frame.height-fontSize/1.2
        
        resetCanvas()
        
    }
    
    
    func displayShapeOf(_ type: ShapeType, with color: UIColor)  {
        self.selectNode.removeFromParent()
        if self.y < 0 {
            //self.y = self.frame.height-fontSize*2
            return
        }
        
        var shape: SKShapeNode!
        
        switch type {
        case .circle:
            shape = SKShapeNode(circleOfRadius: self.fontSize)
        case .square:
            shape = SKShapeNode(rectOf: CGSize(width: self.fontSize, height: self.shapesize))
            
            
        }
        
        shape.fillColor = color
        shape.strokeColor = color
        shape.position = CGPoint(x: self.x, y: self.y)
        
        self.addChild(shape)
        //self.nodes.append(shape)
        updateCoordinates()
    }
    
    func displayText(_ text: String, with color: UIColor) {
        self.selectNode.removeFromParent()
        if self.y < 0 {
            //self.y = self.frame.height-fontSize*2
            return
        }
        
        let label = SKLabelNode(fontNamed: self.fontName)
        label.text = text
        label.fontSize = self.fontSize
        label.fontColor = color
        label.position = CGPoint(x: self.x, y: self.y)
        label.verticalAlignmentMode = .center
        label.horizontalAlignmentMode = .center
        
        self.addChild(label)
        //self.nodes.append(label)
        
        print("\(label)")
        
        
        updateCoordinates()
        
    }
    
    func updateCoordinates() {
        //self.x += self.fontSize
        let factor = CGFloat((self.fontSize*1.5)/20.0)
        self.x += self.fontSize/factor
        
        if self.x > self.frame.width {
            //self.x = fontSize/1.5
            self.x = 0
            let fy = CGFloat((self.fontSize*1.2)/20.0)
            self.y -= self.fontSize/fy
            //self.y -= self.fontSize
            return
        }
    }
    
    
}
