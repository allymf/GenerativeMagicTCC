//#-hidden-code
//
//  See LICENSE folder for this template’s licensing information.
//
//  Abstract:
//  The Swift file containing the source code edited by the user of this playground book.
//

//#-code-completion(everything, hide)
//#-code-completion(identifier, show, displayNextCharacterIn(fontSize:))
//#-code-completion(snippet, show, color, position, text, fontSize, chalck, futura, noteworthy)


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

public typealias Position = Int
public typealias Color = Float

func displayNextCharacterIn(_: String, _: Color, _: Position, fontSize: Double) {
    var settings = CanvasSettings(mode: .text, shape: .circle, font: fontType, size: fontSize, step: 0.01, text: text)
    let data = NSKeyedArchiver.archivedData(withRootObject: settings)
    liveView.send(.data(data))
}

let pixels: [Pixel] = [Pixel(at: 12, with: 11.0)]
//#-end-hidden-code
/*:
 During the period which typewriters were the standard, some people use to make drawings using the types. This kind of expression evolved when computers were introduced and along with them lots of different characters.
 
 Due to computers limitations at the time, that would render text really well and fast but could not do so with other more complex graphics. People used text to create graphics and different kinds of lettering pieces.
 
 Here’s a little show case:
 
 ![An ASCII Art style lettering, reading WWDC 19](wwdc19.png "An ASCII Art style lettering, reading WWDC 19")
 
 ## Hands on:
 
 I hope you remember the image processing routine, because we’re going to use it again to create an ASCII art intervention on an image.
 
 The code will be very similar, but instead of drawing a shape, we are going to write a **letter** in the pixel’s **position** and using the pixel **color**.
 
 So, let's configure the text that's gonna compose the Artwork:
 
 You can set the **text** to be written, its **font** and its **size**.
 
 */

// Text Configuration
text = /*#-editable-code Text to be shown*/"WWDC"/*#-end-editable-code*/

// Available fonts are chalck, futura, noteworthy
fontType = /*#-editable-code*/chalck/*#-end-editable-code*/

/*:
 
 * callout(Tip):
 You can create a ASCII art of your photo using your name, that’s how personal it can get :)
 
 
 The for in loop is below. pretty familiar, huh? But now we are going to use a function called `displayNextCharacterIn`
 
 */

for pixel in pixels {
    let color: Color = pixel.color
    let position: Position = pixel.position
    
    /*#-editable-code Tap to enter code*//*#-end-editable-code*/
}

/*:
 
 Feel proud of your creation? Tap the three dots button and then tap Take Picture, so you can print it and put it on the fridge. 😎
 
 [Next: Conclusion](@next)
 
 */
