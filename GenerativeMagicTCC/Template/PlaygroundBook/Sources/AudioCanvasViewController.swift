//
//  ViewController.swift
//  AudioDemo
//
//  Created by Alysson Moreira on 30/09/19.
//  Copyright © 2019 Alysson Moreira. All rights reserved.
//

import UIKit
import PlaygroundSupport

public class AudioCanvasViewController: UIViewController, PlaygroundLiveViewSafeAreaContainer {
    
    public var manager: AudioManager = AudioManager()
    
    
    // Views
    public lazy var playButton: UIButton = {
        let button = UIButton(type: UIButton.ButtonType.system)
        button.setTitle("Play", for: .normal)
        return button
    }()
    
    public lazy var undoButton: UIButton = {
        let button = UIButton(type: UIButton.ButtonType.system)
        button.setTitle("Undo", for: .normal)
        return button
    }()
    
    public lazy var clearButton: UIButton = {
        let button = UIButton(type: UIButton.ButtonType.system)
        button.setTitle("Clear", for: .normal)
        return button
    }()
    
    public var canvas = CanvasView()
    
    
    // Canvas Configuration
//    let minimumConstant: CGFloat =
//    let maximumConstant: CGFloat =
//    var initialColor: UIColor =
//    var highestColor: UIColor =
    public var setting = AudioInteractionSettings(minimumSize: 30.0, maximumSize: 80.0, initialColor: #colorLiteral(red: 0.9290261865, green: 0.8611106277, blue: 0, alpha: 0), highestColor: #colorLiteral(red: 0.264562726, green: 0.1883445978, blue: 1, alpha: 0))
    
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(playButton)
        self.view.addSubview(undoButton)
        self.view.addSubview(clearButton)
        
        self.view.addSubview(canvas)
//
//        self.view.backgroundColor = .white
        self.canvas.backgroundColor = .white
        
        
        self.applyConstraints()

        playButton.addTarget(self, action: #selector(tapped), for: .touchUpInside)
        undoButton.addTarget(self, action: #selector(undoTapped), for: .touchUpInside)
        clearButton.addTarget(self, action: #selector(clearTapped), for: .touchUpInside)


        self.canvas.layer.borderColor = UIColor.black.cgColor
        self.canvas.layer.borderWidth = 2

        self.canvas.strokeColor = self.setting.initialColor.cgColor
        self.canvas.circleRadius = CGFloat(self.setting.minimumSize)

        canvas.isUserInteractionEnabled = true
        
        manager.delegate = self
        //canvas.delegate = self
        
    }

    @objc public func tapped(_ sender: Any) {
        if !manager.player.isPlaying {
            self.playButton.setTitle("Pause", for: .normal)
        } else {
            self.playButton.setTitle("Play", for: .normal)
        }

        manager.play()
        
    }
    
    @objc public func undoTapped(_ sender: Any) {
        self.canvas.undo()
    }
    @objc public func clearTapped(_ sender: Any) {
        self.canvas.clear()
    }
    
}

// DEBUG ONLY
//extension AudioCanvasViewController: CanvasDifferDelegate {
//    func circles(_ numbers: Int) {
//        DispatchQueue.main.async {
//            self.undoButton.setTitle("\(numbers)", for: .normal)
//
//        }
//
//
//    }
//}

// -MARK: PG MessageHandler
extension AudioCanvasViewController: PlaygroundLiveViewMessageHandler {
    public func liveViewMessageConnectionOpened() {
        // Implement this method to be notified when the live view message connection is opened.
        // The connection will be opened when the process running Contents.swift starts running and listening for messages.
        //self.undoButton.setTitle("Abriu", for: .normal)
    }
    
    public func liveViewMessageConnectionClosed() {
        // Implement this method to be notified when the live view message connection is closed.
        // The connection will be closed when the process running Contents.swift exits and is no longer listening for messages.
        // This happens when the user's code naturally finishes running, if the user presses Stop, or if there is a crash.
        //self.undoButton.setTitle("Fechou", for: .normal)
    }
    
    
    public func receive(_ message: PlaygroundValue) {
        // Implement this method to receive messages sent from the process running Contents.swift.
        // This method is *required* by the PlaygroundLiveViewMessageHandler protocol.
        // Use this method to decode any messages sent as PlaygroundValue values and respond accordingly.
        
        //delegate?.setupWith(fontName: self.fontName, fontSize: diameter)
        //delegate?.resetCanvas()
        //self.resetIteration()
        
        //self.lbDebug.text = "Recebeu"
        //self.undoButton.setTitle("Recebeu", for: .normal)
        
        switch message {
        case .string( _):
            break
        //self.text = value
        case .data(let value):
            guard let newSettings = NSKeyedUnarchiver.unarchiveObject(with: value) as? AudioInteractionSettings else {break}
            self.setting = newSettings
            //setUpFor(newSettings)
            
        default:
            self.undoButton.setTitle("Carai Burracha", for: .normal)
        }
        
    }
        
    
    
    
}

extension AudioCanvasViewController: AudioManagerDelegate {
    func didUpdatePitch(_ value: CGFloat) {

        let interColor = UIColor.getIntermediateHue(from: self.setting.initialColor, to: self.setting.highestColor, by: value)
        let diameter = CGFloat(self.setting.maximumSize) * value

        DispatchQueue.main.async {
            //self.undoButton.setTitle("\(value)", for: .normal)
            self.canvas.strokeColor = interColor.cgColor
            self.canvas.circleRadius = (diameter > 0 ? diameter : CGFloat(self.setting.minimumSize))

        }
        
    }
}

// MARK: - Contraints
extension AudioCanvasViewController {

    public func applyConstraints() {

        self.playButton.translatesAutoresizingMaskIntoConstraints = false
        self.undoButton.translatesAutoresizingMaskIntoConstraints = false
        self.clearButton.translatesAutoresizingMaskIntoConstraints = false

        self.canvas.translatesAutoresizingMaskIntoConstraints = false


        NSLayoutConstraint.activate([
            playButton.topAnchor.constraint(equalTo: liveViewSafeAreaGuide.topAnchor, constant: 16),
            playButton.leadingAnchor.constraint(equalTo: liveViewSafeAreaGuide.leadingAnchor, constant: 32)

        ])

        NSLayoutConstraint.activate([
            undoButton.topAnchor.constraint(equalTo: self.playButton.topAnchor),
            undoButton.trailingAnchor.constraint(equalTo: self.clearButton.leadingAnchor, constant: -32)

        ])

        NSLayoutConstraint.activate([
            clearButton.topAnchor.constraint(equalTo: self.playButton.topAnchor),
            clearButton.trailingAnchor.constraint(equalTo: liveViewSafeAreaGuide.trailingAnchor, constant: -32)

        ])

        NSLayoutConstraint.activate([
            canvas.topAnchor.constraint(equalTo: self.playButton.bottomAnchor, constant: 16),
            canvas.leadingAnchor.constraint(equalTo: liveViewSafeAreaGuide.leadingAnchor, constant: 32),
            canvas.trailingAnchor.constraint(equalTo: liveViewSafeAreaGuide.trailingAnchor, constant: -32),
            canvas.bottomAnchor.constraint(equalTo: liveViewSafeAreaGuide.bottomAnchor, constant: -8)

        ])


    }

}
