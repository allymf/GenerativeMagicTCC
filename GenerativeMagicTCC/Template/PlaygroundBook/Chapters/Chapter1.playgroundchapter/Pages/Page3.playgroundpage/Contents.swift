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

// Initial Settings Values

let chalck: Font = .chalck
let futura: Font = .futura
let noteworthy: Font = .noteworthy

var fontType: Font = .chalck
var text: String = ""

let liveView = PlaygroundPage.current.liveView as! PlaygroundRemoteLiveViewProxy

let initialColor = Color(red: 2, green: 3, blue: 1)
let initialPosition = Position(x: 0, y: 0)
public let pixels = [Pixel(at: initialPosition, with: initialColor)]

// Assessment Code
var functionCalled: Bool = false

func assessStatusFor(_ text: String,_ color: Color, _ position: Position, _ fontSize: Double) -> Bool {
    if functionCalled {
        
        if text.count > 0 && color == initialColor && position == initialPosition && fontSize > 0{
            
            let passMessage = NSLocalizedString("PassI2", comment: "I Tried")
            
            PlaygroundPage.current.assessmentStatus = .pass(message: passMessage)
            return true
            
        } else {
            
            let hint1 = NSLocalizedString("Hint1I2", comment: "I Tried")
            let hint2 = NSLocalizedString("Hint2I2", comment: "I Tried")
            let hint3 = NSLocalizedString("Hint3I2", comment: "I Tried")
            let hint4 = NSLocalizedString("Hint4I2", comment: "I Tried")
            
            let hints = [hint1,hint2,hint3,hint4]
            
            PlaygroundPage.current.assessmentStatus = .fail(hints: hints, solution: nil)
            return false
            
            
        }
        
        
    } else {
        
        let hint = NSLocalizedString("HintGI2", comment: "I Tried")
        
        PlaygroundPage.current.assessmentStatus = .fail(hints: [hint], solution: nil)
        return false
    }
    
    
}

//public typealias Position = Int
//public typealias Color = Float

func displayNextCharacterIn(text: String, color: Color, position: Position, fontSize: Double) {
    
    functionCalled = true
    if assessStatusFor(text,color, position, fontSize) {
        var settings = CanvasSettings(mode: .text, shape: .circle, font: fontType, size: fontSize, step: 0.01, text: text)
        let data = NSKeyedArchiver.archivedData(withRootObject: settings)
        liveView.send(.data(data))
    }
}

//#-code-completion(everything, hide)
//#-code-completion(identifier, show, displayNextCharacterIn(text:color:position:fontSize:), color, position, text, fontSize, chalck, futura, noteworthy)
//#-code-completion(description, show, "displayNextCharacterIn(text: String, color: Color, position: Position, fontSize: Double)")
//#-end-hidden-code
/*:#localized(key: "block1")
 During the period which typewriters were the standard, some people use to make drawings using the [types](glossary://type). This kind of expression evolved when computers were introduced and along with them lots of different characters.
 
 Due to computers limitations at the time, that would render text really well and fast but could not do so with other more complex graphics. People used text to create graphics and different kinds of [lettering](glossary://lettering) pieces.
 
 Here’s a little show case:
 
 ![An ASCII Art style lettering, reading WWDC 19](wwdc19.png "An ASCII Art style lettering, reading WWDC 19")
 
 ## Hands on:
 
 I hope you remember the image processing [routine](glossary://routine), because we’re going to use it again to create an [ASCII art](glossary://ascii%20art) intervention on an image.
 
 The code will be very similar, but instead of drawing a shape, we are going to write a **letter** in the pixel’s **position** and using the pixel **color**.
 
 So, let's configure the text that's gonna compose the Artwork:
 
 You can set the **text** to be written, its **font** and its **size**.
 
 */

// Text Configuration
text = /*#-editable-code Text to be shown*/"WWDC"/*#-end-editable-code*/

// Available fonts are chalck, futura, noteworthy
fontType = /*#-editable-code*/chalck/*#-end-editable-code*/

/*:#localized(key: "block2")
 
 * callout(Tip):
 You can create a ASCII art of your photo using your name, that’s how personal it can get :)
 
 
 The for in loop is below. pretty familiar, huh? But now we are going to use a function called `displayNextCharacterIn`
 
 */

for pixel in pixels {
    let color: Color = pixel.color
    let position: Position = pixel.position
    
    /*#-editable-code Tap to enter code*//*#-end-editable-code*/
}

/*:#localized(key: "block3")
 
 Feel proud of your creation? Tap the three dots button and then tap Take Picture, so you can print it and put it on the fridge. 😎
 
 [Next: Conclusion](@next)
 
 */
