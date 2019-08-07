//
//  CanvasViewController.swift
//  Book_Sources
//
//  Created by Alysson Moreira on 20/03/19.
//

import SpriteKit
import PlaygroundSupport
import Foundation

@objc(Book_Sources_CanvasViewController)
class CanvasViewController: UIViewController, PlaygroundLiveViewSafeAreaContainer {

    // -MARK: Views
    var contentView: UIView!
    
    var spriteKitView: SKView!
    var btPickImage: UIButton!
    
    
    var scene: CanvasSKScene!
    
    var delegate: CanvasDelegate?
    
    
    // -MARK: Iteration variables
    var imgPixels = [UInt32]()
    
    var timer = Timer()
    
    var image = UIImage()
    
    var textCount = 0
    
    var x = 0
    var y = 0
    var index = 0
    
    //- MARK: Settings
    var cvSettings = CanvasSettings(mode: .shape,font: .chalck, size: 0.0, step: 0.02, text: "Erro")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // Retrieving the widgets
        guard let content = (self.view.subviews.filter {$0.restorationIdentifier == "content"}).first else { fatalError("Carai Burracha") }
        self.contentView = content
        
        
        guard let skv = (self.contentView.subviews.filter {$0.restorationIdentifier == "SKMain"}).first as? SKView else { fatalError("Carai Burracha") }
        self.spriteKitView = skv
        
        guard let bt = (self.contentView.subviews.filter {$0.restorationIdentifier == "btPickImage"}).first as? UIButton else { fatalError("Carai Burracha") }
        self.btPickImage = bt
        
        
        // Consider the safearea of liveview
        NSLayoutConstraint.activate([
            self.contentView.bottomAnchor.constraint(equalTo: liveViewSafeAreaGuide.bottomAnchor),
            self.contentView.topAnchor.constraint(equalTo: liveViewSafeAreaGuide.topAnchor)
            ])
        
        
        
        // Setting Tap Action to btPickImage
        self.btPickImage.addTarget(self, action: #selector(CanvasViewController.didTapPick(_:)), for: .touchUpInside)
        
        
        // Configuring the scene and the skView
        scene = CanvasSKScene(size: spriteKitView.frame.size)
        scene.backgroundColor = .black
        
        self.delegate = scene
        delegate?.setupWith(fontName: self.cvSettings.font.rawValue, fontSize: CGFloat(self.cvSettings.size))
        
        self.spriteKitView.presentScene(scene)
        
        
        
    }
    
    
    func loadPixels(of image : UIImage) {
        let inputCGImage = image.cgImage!
        let width = inputCGImage.width
        let height = inputCGImage.height
        
        let bytesPerPixel = 4;
        let bytesPerRow = bytesPerPixel * width;
        let bitsPerComponent = 8;
        
        var pixels = [UInt32](repeating: 0, count: width * height)
        
        let colorSpace = CGColorSpaceCreateDeviceRGB();
        
        let context = CGContext(data: &pixels, width: width, height: height,
                                bitsPerComponent: bitsPerComponent, bytesPerRow: bytesPerRow, space: colorSpace,
                                bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue | CGBitmapInfo.byteOrder32Big.rawValue);
        
        
        context?.draw(inputCGImage, in: CGRect(x: 0, y: 0, width: CGFloat(width),height: CGFloat(height)))
        
        self.imgPixels = pixels
        
    }
    
    func setBackgroundColor(_ color: UIColor) {
        self.view.backgroundColor = color
        self.contentView.backgroundColor = color
        self.spriteKitView.backgroundColor = color
        self.scene.backgroundColor = color
    
    }
    
    func resetIteration(){
        self.index = 0
        self.x = 0
        self.y = 0
        self.textCount = 0
    }

    @objc
    func updateTimer(){
        
        if index >= self.imgPixels.count - 1 || self.cvSettings.size <= 0.0 {
            print("Acabouu")
            timer.invalidate()
            return
        }
        
        
        let color = UIColor(imgPixels[index])
        
        switch self.cvSettings.mode {
        case .text:
            if (self.cvSettings.text.count > 0){
                let chars = Array(self.cvSettings.text.uppercased())
                let letter = chars[textCount]
                delegate?.displayText("\(letter)", with: color)
                textCount+=1
                if (textCount >= chars.count) {
                    textCount = 0
                }
            } else {
                delegate?.displayText(" ", with: color)
            }
        case .shape:
            delegate?.displayShapeOf(self.cvSettings.shape, with: color)
        }
        
        
        guard let imgWidth = self.image.cgImage?.width else {return}
        
        let factor:CGFloat = CGFloat((self.cvSettings.size*1.5)/20)
        
        self.x += Int(((CGFloat(self.cvSettings.size)/factor) * CGFloat(imgWidth)) /  (self.spriteKitView.scene?.frame.width)!)
        //self.x += Int(diameter)
        
        if self.x > self.image.cgImage!.width {
            //self.x = Int(((diameter/1.5) * CGFloat(imgWidth)) /  (self.spriteKitView.scene?.frame.width)!)
            self.x = 0
            
            //            self.y += Int(((diameter/1.2) * CGFloat(self.image!.cgImage!.height)) / (self.scene.frame.height))
            self.y += Int(self.cvSettings.size)
        }
        
        
        
        
        
        index = x+(y*imgWidth)
        
    }
}

// -MARK: PG MessageHandler
extension CanvasViewController: PlaygroundLiveViewMessageHandler {
    public func liveViewMessageConnectionOpened() {
        // Implement this method to be notified when the live view message connection is opened.
        // The connection will be opened when the process running Contents.swift starts running and listening for messages.
        //self.lbDebug.text = "Abriu Conexão"
    }
    
    public func liveViewMessageConnectionClosed() {
        // Implement this method to be notified when the live view message connection is closed.
        // The connection will be closed when the process running Contents.swift exits and is no longer listening for messages.
        // This happens when the user's code naturally finishes running, if the user presses Stop, or if there is a crash.
        //self.lbDebug.text = "Fechou Conexão"
    }
    
    
    public func receive(_ message: PlaygroundValue) {
        // Implement this method to receive messages sent from the process running Contents.swift.
        // This method is *required* by the PlaygroundLiveViewMessageHandler protocol.
        // Use this method to decode any messages sent as PlaygroundValue values and respond accordingly.
        
        //delegate?.setupWith(fontName: self.fontName, fontSize: diameter)
        delegate?.resetCanvas()
        self.resetIteration()
        
        //self.lbDebug.text = "Recebeu"

        switch message {
        case .string( _):
            break
            //self.text = value
        case .data(let value):
            guard let newSettings = NSKeyedUnarchiver.unarchiveObject(with: value) as? CanvasSettings else {break}
            setUpFor(newSettings)
            
        default:
            self.btPickImage.setTitle("Carai Burracha", for: .normal)
        }
        
    }
    
    
    func setUpFor(_ newSettings: CanvasSettings) {
        resetIteration()
        self.cvSettings = newSettings
        if newSettings.size > 0.0 {
        cvSettings.size += 9.0
        delegate?.setupWith(fontName: self.cvSettings.font.rawValue, fontSize: CGFloat(self.cvSettings.size))
          timer = Timer.scheduledTimer(timeInterval: 0.01, target: self,   selector: (#selector(CanvasViewController.updateTimer)), userInfo: nil, repeats: true)
            
        }
            
        
        
    }
    
    
}

// MARK: ImagePickerDelegate
extension CanvasViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func getNewSize(of image: UIImage) -> CGSize {
        
        var newSize = CGSize()
        let sceneSize: CGSize = self.scene.frame.size
        let imageSize: CGSize = CGSize(width: image.cgImage!.width, height: image.cgImage!.height)
        
        
        if sceneSize.width > sceneSize.height{
            var width: CGFloat = 0.0
            let height: CGFloat = sceneSize.height
            
            //let ar = imageSize.height/imageSize.width
            let diff = height /  imageSize.height
            
            //width = (height*imageSize.width)/imageSize.height
            //width = imageSize.width*height
            width = imageSize.width*diff
            
            newSize = CGSize(width: width, height: height)
            
        } else {
            let width: CGFloat = sceneSize.width
            var height: CGFloat = 0.0
            
            //let ar = imageSize.width/imageSize.height
            let diff = width /  imageSize.width
            //height = (width*imageSize.height)/imageSize.width
            //height = width*ar
            height = imageSize.height * diff
            
            newSize = CGSize(width: width, height: height)
        }
        return newSize
    }
    
    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        guard let image = info[.originalImage] as? UIImage else {return}
        
        
        self.image = image.scaledToSize(getNewSize(of: image))!

        self.loadPixels(of: self.image)
        resetIteration()
        delegate?.resetCanvas()
        
        delegate?.displayFeedBack(text: "Now Run your code")
        
        if self.cvSettings.size > 0.0 {
//        timer = Timer.scheduledTimer(timeInterval: 0.01, target: self,   selector: (#selector(CanvasViewController.updateTimer)), userInfo: nil, repeats: true)
        } else {
            resetIteration()
            
        }
            
        picker.dismiss(animated: false, completion: nil)
    }
    
    public func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    @objc
    func didTapPick(_ sender: Any) {
        
        
        self.timer.invalidate()
        
        let alert = UIAlertController(title: "Pick an image", message: "Select the source of the photo", preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (action) in
            self.pickImageFrom(.camera)
        }))
        
        alert.addAction(UIAlertAction(title: "Library", style: .default, handler: { (action) in
            self.pickImageFrom(.photoLibrary)
        }))
        
        alert.addAction(UIAlertAction(title: "Saved Photos", style: .default, handler: { (action) in
            self.pickImageFrom(.savedPhotosAlbum)
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
        }))
        
        if let popoverVC = alert.popoverPresentationController {
            //            popoverVC.barButtonItem = sender as? UIBarButtonItem
            popoverVC.sourceView = self.view
            popoverVC.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY, width: 0, height: 0)
            popoverVC.permittedArrowDirections = []
            
        }
        
        self.present(alert, animated: true, completion: nil)
        
    }
    
    func pickImageFrom(
        _ sourceType: UIImagePickerController.SourceType){
        
        let myPickerController = UIImagePickerController()
        myPickerController.delegate = self;
        myPickerController.sourceType = sourceType
        
        myPickerController.modalPresentationStyle = UIModalPresentationStyle.custom
        myPickerController.transitioningDelegate = self
    
        
        self.present(myPickerController, animated: true, completion: nil)
        
        
    }
    
    
}

extension CanvasViewController: UIViewControllerTransitioningDelegate, PresentationDataSource {
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        let vc = PresentationViewController(presentedViewController: presented, presenting: presenting)
        vc.dataSource = self
        
        return vc
        
        
    }
    
    func size(for: UIPresentationController) -> CGRect {
        return self.contentView.frame
    }
    
}
