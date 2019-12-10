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
/*:#localized(key: "conclusion")
 Diferentiated Audio
 */


let minimumSize: Double = /*#-editable-code*/<#T##Minimum circle size##Double#>/*#-end-editable-code*/
let maximumSize: Double = /*#-editable-code*/<#T##Maximum circle size##Double#>/*#-end-editable-code*/


let initialColor: Color = /*#-editable-code Base color*/#colorLiteral(red: 0.9290261865, green: 0.8611106277, blue: 0, alpha: 0.4901808647)/*#-end-editable-code*/
let highestColor: Color = /*#-editable-code Top color*/#colorLiteral(red: 0.264562726, green: 0.1883445978, blue: 1, alpha: 0.5)/*#-end-editable-code*/


var currentSize: Double = minimumSize
var currentColor: Color = initialColor

func didUpdatePitch(with value: Double) {
    
    currentSize = /*#-editable-code*/<#code#>/*#-end-editable-code*/
    currentColor = /*#-editable-code*/<#code#>/*#-end-editable-code*/
    
}

//#-hidden-code

func assessStatusFor(_ color: Color, _ position: Position, _ size: Double) -> Bool {
    if functionCalled {
        
        if color == currentColor && position == initialPosition && size > 0 &&
            color == getIntermediateColor(from: initialColor, to: highestColor, by: factor) && size == currentSize {
            
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

func drawCircleWith(color: Color, position: Position, size: Double) {
    functionCalled = !functionCalled
    
    if assessStatusFor(color, position, size) {
        
        var settings = AudioInteractionSettings(minimumSize: minimumSize, maximumSize: maximumSize, initialColor: initialColor.getTranslucent(), highestColor: highestColor.getTranslucent())
        let data = NSKeyedArchiver.archivedData(withRootObject: settings)
        liveView.send(.data(data))
        
    }
}
//#-end-hidden-code

func handleTouch(at position: Position) {
    
    /*#-editable-code*/<#code#>/*#-end-editable-code*/
    
}


//#-hidden-code

didUpdatePitch(with: factor)
handleTouch(at: initialPosition)

//#-end-hidden-code
