//#-hidden-code
//
//  See LICENSE folder for this template’s licensing information.
//
//  Abstract:
//  The Swift file containing the source code edited by the user of this playground book.
//

import PlaygroundSupport
import UIKit

typealias Color = UIColor



// Assessment Code
var functionCalled: Bool = false
let factor = 0.1231293298988

let initialPosition = Position(x: 0, y: 0)

let liveView = PlaygroundPage.current.liveView as! PlaygroundRemoteLiveViewProxy




func getIntermediateColor(from firstColor: Color, to secondColor: Color, by factor: Double) -> UIColor {
    return UIColor.getIntermediateHue(from: firstColor, to: secondColor, by: CGFloat(factor))
}

//currentSize = minimumSize + (maximumSize * value)
//currentColor = getIntermediateColor(from: initialColor, to: highestColor, by: value)

//drawCircleWith(color: currentColor, position: position, size: currentSize)

//#-end-hidden-code
//#-code-completion(everything, hide)
//#-code-completion(identifier, show, drawCircleWith(color:position:size:), getIntermediateColor(from:to:by:), initialColor, highestColor, minimumSize, maximumSize, currentSize, currentColor, position, value)
//#-code-completion(description, show, "drawCircleWith(color: Color, position: Position,size: Double)", "getIntermediateColor(from: Color, to: Color, by: Double)")
/*:#localized(key: "intro")
 Sound can be another great source of data to be used artistical interventions. In an audio file all its music characteristics are represented by data and it's possible to analyse it. Therefore, being possible to create a visualization to this data using shapes, colors and much more.🔊
 
 On this very interaction you will do exactly that, bit with a twist: essa visualização muda também conforme você interage. 😎
 
 
 ### Hands on:
 
 The screen beside has a black bordered "canvas" which you can use to draw using circles. However, for that to be possible it's necessary that you program some functions. Making the drawn circles on the canvas have their size and color affected by the music pitch. 🎶
 
 When you tap the **Play** button, a song starts and its current pitch (high or low) is identified and passed to the `didUpdatePitch` function through `value` parameter. It goes from 0.0 tom 1.0. Also, when you touch the black bordered canvas the `handleTouch` function is called an the touch `position` is passed as a parameter.
 
 Right below, there are constants that you need to define the values with the minimum and maximum values for size and color that you wish the circles to have.
 */


let minimumSize: Double = /*#-editable-code*/<#T##Minimum circle size##Double#>/*#-end-editable-code*/
let maximumSize: Double = /*#-editable-code*/<#T##Maximum circle size##Double#>/*#-end-editable-code*/


let initialColor: Color = /*#-editable-code Base color*/#colorLiteral(red: 0.9290261865, green: 0.8611106277, blue: 0, alpha: 0.4901808647)/*#-end-editable-code*/
let highestColor: Color = /*#-editable-code Top color*/#colorLiteral(red: 0.264562726, green: 0.1883445978, blue: 1, alpha: 0.5)/*#-end-editable-code*/

/*:#localized(key: "vars")
 Right after that, two variables are created to store the different values that'll be computed at every pitch change.
 */

var currentSize: Double = minimumSize
var currentColor: Color = initialColor

/*:#localized(key: "didUpdate")
 Now begins the fun part, you're going to implement the changes to `currentSize` and `currentColor` inside the `didUpdatePitch` function, because they'll be used later on.
 
 The values must be based on the passed attribute `value`. The variable `currentSize` has to go from `minimumSize` up to `minimumSize` + `maximumSize` at maximum. The `currentColor` must interpolate between the two colors that you defined, but don't be afraid, you just need to use the `getIntermediateColor` function. Remember to pass the initial color as the first parameter.
*/

func didUpdatePitch(with value: Double) {
    
    currentSize = minimumSize + (/*#-editable-code*/<#code#>/*#-end-editable-code*/)
    currentColor = /*#-editable-code*/<#code#>/*#-end-editable-code*/
    
}

//#-hidden-code

func assessStatusFor(_ color: Color, _ position: Position, _ size: Double) -> Bool {
    if functionCalled {
        
        if color == currentColor && position == initialPosition && size > 0 &&
            color == getIntermediateColor(from: initialColor, to: highestColor, by: factor) && size == currentSize && size == (minimumSize+(maximumSize*factor)) {
            
            let passMessage = NSLocalizedString("PassI3", comment: "I Tried")
            
            PlaygroundPage.current.assessmentStatus = .pass(message: passMessage)
            return true
            
        } else {
            
            let hint1 = NSLocalizedString("Hint1I3", comment: "I Tried")
            let hint2 = NSLocalizedString("Hint2I3", comment: "I Tried")
            let hint3 = NSLocalizedString("Hint3I3", comment: "I Tried")
            
            let hints = [hint1, hint2, hint3]
            
            PlaygroundPage.current.assessmentStatus = .fail(hints: hints, solution: nil)
            return false
            
            
        }
        
        
    } else {
        
        let hint1 = NSLocalizedString("Hint1I3", comment: "I Tried")
        let hint2 = NSLocalizedString("Hint2I3", comment: "I Tried")
        let hint3 = NSLocalizedString("Hint3I3", comment: "I Tried")
        
        let hints = [hint1, hint2, hint3]
        PlaygroundPage.current.assessmentStatus = .fail(hints: hints, solution: nil)
        return false
    }
    
    
}

func drawCircleWith(color: Color, position: Position, size: Double) {
    functionCalled = !functionCalled
    
    if assessStatusFor(color, position, size) {
        
        var settings = AudioInteractionSettings(minimumSize: minimumSize, maximumSize: maximumSize, initialColor: initialColor.getTranslucent(), highestColor: highestColor.getTranslucent())
        let data = NSKeyedArchiver.archivedData(withRootObject: settings)
        liveView.send(.data(data))
        
    }
}
//#-end-hidden-code

/*:#localized(key: "handle")
Do you remember the `drawCircleWith` function from the first interaction? We're going to use it again inside the `handleTouch` function. Remember to use the variables with the current values to get the desired result.
 */

func handleTouch(at position: Position) {
    
    /*#-editable-code*/<#code#>/*#-end-editable-code*/
    
}

/*:#localized(key: "end")
 When it's all ready tap the **Run My Code** button, after that tap **Play** to start the music and its analysis. Unleash your creativity touching and swipping in the black bordered canvas.
 
 You can change the `minimumSize`, `maximumSize`,  `initialColor`, `highestColor` values and tap **Run My Code** again to test new possibilities without losing your previous strokes.🎨🖌
 
  [Next: Conclusion](@next)
*/
//#-hidden-code

didUpdatePitch(with: factor)
handleTouch(at: initialPosition)

//#-end-hidden-code
