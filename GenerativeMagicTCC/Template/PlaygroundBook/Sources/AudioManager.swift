//
//  Audio.swift
//  AudioDemo
//
//  Created by Alysson Moreira on 30/09/19.
//  Copyright © 2019 Alysson Moreira. All rights reserved.
//


import Foundation
import AVFoundation

public class AudioManager {

    public var engine = AVAudioEngine()
    public var player = AVAudioPlayerNode()
    public var rateEffect = AVAudioUnitTimePitch()

    public var audioFile: AVAudioFile?
    {
        didSet {
            if let audioFile = audioFile {
                audioLengthSamples = audioFile.length
                audioFormat = audioFile.processingFormat
                audioSampleRate = Float(audioFormat?.sampleRate ?? 44100)
                audioLengthSeconds = Float(audioLengthSamples) / audioSampleRate
            }
        }
    }
    public var audioFileURL: URL?
//    {
//        didSet {
//            if let audioFileURL = audioFileURL {
//                audioFile = try? AVAudioFile(forReading: audioFileURL)
//            }
//        }
//    }
    public var audioBuffer: AVAudioPCMBuffer?
//
//    // MARK: other properties
    public var audioFormat: AVAudioFormat?
    public var audioSampleRate: Float = 0
    public var audioLengthSeconds: Float = 0
    public var audioLengthSamples: AVAudioFramePosition = 0
    public var needsFileScheduled = true
    public let rateSliderValues: [Float] = [0.5, 1.0, 1.25, 1.5, 1.75, 2.0, 2.5, 3.0]
//    public var rateValue: Float = 1.0 {
//        didSet {
//            rateEffect.rate = rateValue
//            //updateRateLabel()
//        }
//    }
//    public var updater: CADisplayLink?
//    public var currentFrame: AVAudioFramePosition {
//        guard let lastRenderTime = player.lastRenderTime,
//            let playerTime = player.playerTime(forNodeTime: lastRenderTime) else {
//                return 0
//        }
//
//        return playerTime.sampleTime
//    }
    public var seekFrame: AVAudioFramePosition = 0
//    public var currentPosition: AVAudioFramePosition = 0
//    public let pauseImageHeight: Float = 26.0
    public let minDb: Float = -80.0
//
    public var value: CGFloat = 0
    {
        didSet {
            delegate?.didUpdatePitch(self.value)
        }
    }
    
    //public let captureSession = AVCaptureSession()
    //public var delegate: AudioManagerDelegate?
    
    var delegate: AudioManagerDelegate?
    
    //public var stat = "Deu Errado"
    
    public init() {
        
        
        //updater = CADisplayLink(target: self, selector: #selector(updateUI))
        //        updater?.add(to: .current, forMode: .defaultRunLoopMode)
        //        updater?.isPaused = true
        
        // 1
        //audioFileURL = Bundle.main.url(forResource: "First", withExtension: "m4a")
        //self.audioFileURL = Bundle.main.url(forResource: "ukulele", withExtension: "mp3")
        
        if let audioFileURL = Bundle.main.url(forResource: "ukulele", withExtension: "mp3") {
        audioFile = try? AVAudioFile(forReading: audioFileURL)
        }
        
//        // 2
        engine.attach(player)
        engine.attach(rateEffect)
        engine.connect(player, to: rateEffect, format: audioFormat)
        engine.connect(rateEffect, to: engine.mainMixerNode, format: audioFormat)

        engine.prepare()

        do {
            // 3
            try engine.start()
        } catch let error {
            NSLog(error.localizedDescription)
        }
        
    }
    
    public func scheduleAudioFile() {
        guard let audioFile = audioFile else { return }

        seekFrame = 0
        player.scheduleFile(audioFile, at: nil) { [weak self] in
            self?.needsFileScheduled = true
        }
    }

    public func play() {
        if player.isPlaying {
            disconnectVolumeTap()
            //updater?.isPaused = true
            player.pause()
        } else {
            //updater?.isPaused = false
            connectVolumeTap()
            if needsFileScheduled {
                needsFileScheduled = false
                scheduleAudioFile()
            }
            player.play()
        }
    }
    
    
    public func connectVolumeTap() {
        let format = engine.mainMixerNode.outputFormat(forBus: 0)
        engine.mainMixerNode.installTap(onBus: 0, bufferSize: 1024, format: format) { (buffer, when) in

            guard let channelData = buffer.floatChannelData
                else {
                    return
            }

            let channelDataValue = channelData.pointee
            let channelDataValueArray = stride(from: 0,
                                               to: Int(buffer.frameLength),
                                               by: buffer.stride).map{ channelDataValue[$0] }
            let channelMap = channelDataValueArray.map{ $0 * $0 }.reduce(0, +)
            let rms = sqrt(channelMap / Float(buffer.frameLength))
            let avgPower = 20 * log10(rms)
            let meterLevel = self.scaledPower(power: avgPower)

            //DispatchQueue.main.async {
            //!updater.isPaused ?
            //let value = CGFloat(min((meterLevel * self.pauseImageHeight), self.pauseImageHeight))
            self.delegate?.didUpdatePitch(CGFloat(meterLevel))
            //}
        }
    }

    public func scaledPower(power: Float) -> Float {
        guard power.isFinite else { return 0.0 }

        if power < minDb {
            return 0.0
        } else if power >= 1.0 {
            return 1.0
        } else {
            return (abs(minDb) - abs(power)) / abs(minDb)
        }
    }

    public func disconnectVolumeTap() {
        engine.mainMixerNode.removeTap(onBus: 0)
        self.value = 0
    }
    
}

protocol AudioManagerDelegate: class {
    func didUpdatePitch(_ value: CGFloat)
}
