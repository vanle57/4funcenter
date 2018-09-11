//
//  Speaker.swift
//  MyApp
//
//  Created by PCM0019 on 8/6/18.
//  Copyright © 2018 Asian Tech Co., Ltd. All rights reserved.
//

import Foundation
import AVFoundation

class Speaker: NSObject {

    // MARK: - Singleton
    static let shared: Speaker = {
        let shared = Speaker()
        return shared
    }()

    // MARK: - Properties
    let synth = AVSpeechSynthesizer()
    let rate: Float = 2.0
    let language = "en-US"
    var soundEffect: AVAudioPlayer?

    override init() {
        super.init()
    }

    func speak(string: String) {
        let speechUtterance: AVSpeechUtterance = AVSpeechUtterance(string: string)
        speechUtterance.rate = AVSpeechUtteranceMaximumSpeechRate / rate
        speechUtterance.voice = AVSpeechSynthesisVoice(language: language)
        synth.speak(speechUtterance)
    }

    func soundEffect(url: URL) {
        do {
            soundEffect = try AVAudioPlayer(contentsOf: url)
            soundEffect?.play()
        } catch {
        }
    }
}
