//#-hidden-code
//
//  See LICENSE folder for this template’s licensing information.
//
//  Abstract:
//  The Swift file containing the source code edited by the user of this playground book.
//


import PlaygroundSupport
import Foundation
import CoreGraphics

// Assessment Code

var functionCalled: Bool = false


// Initial Settings Values
private let fontType: Font = .chalck
let text: String = " "

let initialColor = Color(red: 1, green: 1, blue: 1)
let initialPosition = Position(x: 0, y: 0)
public let pixels = [Pixel(at: initialPosition, with: initialColor)]

let liveView = PlaygroundPage.current.liveView as! PlaygroundRemoteLiveViewProxy
//public typealias Position = Int
//public typealias Color = Float

func fillColor(_: Color) -> Void {
    print("Boa")
}

func assessStatusFor(_ color: Color, _ position: Position, _ size: Double) -> Bool {
    if functionCalled {
        
        if color == initialColor && position == initialPosition && size > 0 {
            
            let passMessage = NSLocalizedString("PassI1", comment: "I Tried")
            
            PlaygroundPage.current.assessmentStatus = .pass(message: passMessage)
            return true
            
        } else {
            
            let hint1 = NSLocalizedString("Hint1I1", comment: "I Tried")
            let hint2 = NSLocalizedString("Hint2I1", comment: "I Tried")
            
            let hints = [hint1, hint2]
            
            PlaygroundPage.current.assessmentStatus = .fail(hints: hints, solution: nil)
            return false
            
            
        }
        
        
    } else {
        
        let hint = NSLocalizedString("HintGI1", comment: "I Tried")
        
        PlaygroundPage.current.assessmentStatus = .fail(hints: [hint], solution: nil)
        return false
    }
    
    
}

func drawCircleWith(color: Color, position: Position,size: Double)
{
    functionCalled = !functionCalled
    
    if assessStatusFor(color, position, size) {
    
        var settings = CanvasSettings(mode: .shape, shape: .circle, font: fontType, size: size, step: 0.1, text: text)
        let data = NSKeyedArchiver.archivedData(withRootObject: settings)
            liveView.send(.data(data))
        
    }
}
func drawSquareWith(color: Color, position: Position, size: Double) {
    functionCalled = !functionCalled
    
    if assessStatusFor(color, position, size) {
    
        var settings = CanvasSettings(mode: .shape, shape: .square, font: fontType, size: size, step: 0.1, text: text)
        let data = NSKeyedArchiver.archivedData(withRootObject: settings)
        liveView.send(.data(data))
        
    }
}


//#-code-completion(everything, hide)
//#-code-completion(identifier, show, drawCircleWith(color:position:size:), drawSquareWith(color:position:size:), color, position)
//#-code-completion(description, show, "drawCircleWith(color: Color, position: Position,size: Double)", "drawSquareWith(color: Color, position: Position, size: Double)")
//#-end-hidden-code
/*:#localized(key: "block1")
 The first thing I wanna show to you is the bases of image processing. Using the images data to generate something upon it, create an infinity of creative possibilities. Like the creation artistic filters, color analysis, [glitch art](glossary://glitch%20art).
 
 Here's an example of an image intervention I created using code:
 
 ![Photo of a man with long curly hair using rounded glasses in grayscale, followed by a photo of a red galaxy, both of them with arrow in the bottom pointin to a box written "My Filter" which also has a arrow coming from its bottom, pointing to a image that is the combination of both previously said photos in a double exposure technic](ImgFilterShowcase.png "Photo of a man with long curly hair using rounded glasses in grayscale, followed by a photo of a red galaxy, both of them with arrow in the bottom pointin to a box written 'My Filter' which also has a arrow coming from its bottom, pointing to a image that is the combination of both previously said photos in a double exposure technic")
 
 ### But how does it work?
 
 Well, normally you would iterate over a structure that contais every single [pixel](glossary://pixel) data from an image, and at each step do something with that data, like analyzing it, changing it or using it to draw another image.
 
 
 ### Hands on:
 
 Down below there is a [for in](glossary://for) loop that iterates over and [array](glossary://array) of pixels.
 
 - Experiment:
 Here's what we're going to do
 
 1. On each iteration we are going to draw a shape, by using either `drawCircleWith` or `drawSquareWith`.
 
 2. We are going to pass to the selected function: the pixel’s **color**, its **position**, and a **size** value
 
 * callout(Tip):
 Start with a lower number for size, and then experiment with different values to see what happens. But remember to use values greater than zero for something to be shown.
 
 */

for pixel in pixels {
    let color: Color = pixel.color
    let position: Position = pixel.position
    
    /*#-editable-code Tap to enter code*//*#-end-editable-code*/
}

/*:#localized(key: "block2")
 3. After that you should Tap the big white button written **Pick an image** to select what we are going to analyse.
 
 4. Finally, tap the **Run My Code** button
 
 
 If everything went alright, you should now have a stylized version of the photo you just choose. Neat, ain't it? 😄
 
 If you want so, tap the three dots button up in the Nav Bar a select **Take Picture**, so you can save your artwork. Maybe show off to your friends on social media. 😜
 
 [Next: ASCII Art](@next)
 
 */
