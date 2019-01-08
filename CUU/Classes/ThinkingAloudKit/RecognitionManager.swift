//
//  RecognitionManager.swift
//  thinkingaloud
//
//  Created by Lara Marie Reimer on 20.05.18.
//  Copyright © 2018 Lara Marie Reimer. All rights reserved.
//

import Foundation
import Speech

class RecognitionManager {
    
    var previousCrumbId = ""
    
    let speechRecognizer: SFSpeechRecognizer? = SFSpeechRecognizer()
    let request = SFSpeechAudioBufferRecognitionRequest()
    var recognitionTask: SFSpeechRecognitionTask?
    
    var lastRecognition = ""
    let audioEngine = AVAudioEngine()
    
    init() {
        // Set up the audio session.
        let audioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setCategory(.playAndRecord, mode: .default)
            try audioSession.setActive(true, options: .notifyOthersOnDeactivation)
        } catch {
            print("An error has occurred while setting the AVAudioSession.")
        }
    }
    
    func recordAndRecognizeSpeech() {
        let node = audioEngine.inputNode
        let recordingFormat = node.outputFormat(forBus: 0)
        node.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { (buffer, _) in
            self.request.append(buffer)
        }
        
        audioEngine.prepare()
        do {
            try audioEngine.start()
        } catch {
            print(error)
        }
        
        guard let myRecognizer = SFSpeechRecognizer() else { return }
        
        if !myRecognizer.isAvailable { return }
        
        recognitionTask = myRecognizer.recognitionTask(with: request, resultHandler: { (result, _) in
            if let result = result {
                self.lastRecognition = result.bestTranscription.formattedString
            }
        })
    }
    
    static func checkAuthorizationAndStart(with completion:@escaping (_ granted: Bool) -> Void) {
        SFSpeechRecognizer.requestAuthorization { authStatus in
            /* The callback may not be called on the main thread. Add an
             operation to the main queue to update the record button's state.
             */
            OperationQueue.main.addOperation {
                switch authStatus {
                case .authorized:
                    let synth = AVSpeechSynthesizer()
                    let myUtterance = AVSpeechUtterance(string: "Los gehts! Fang an zu reden.")
                    myUtterance.rate = 0.5
                    synth.speak(myUtterance)
                    
                    completion(true)
                case .denied:
                    completion(false)
                case .restricted:
                    completion(true)
                case .notDetermined:
                    completion(true)
                }
            }
        }
    }
    
    func stopRecording(isLast: Bool, with completion:@escaping (_ result: String, _ analyzedResult: [String : String]) -> Void) {
        // Give it 1 second to finish.
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            self.audioEngine.stop()
            self.request.endAudio()
            DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
                self.recognitionTask?.finish()
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute: {
                    var analyzedResult : [String : String] = [:]
                    
                    let analyzer = RecognitionAnalyzer(with: self.lastRecognition)
                    analyzer.analyze(with: { (token, result, isLast) in
                        analyzedResult[token] = result
                        print(analyzedResult)
                        
                        if isLast {
                            completion(self.lastRecognition, analyzedResult)
                        }
                    })
                })
            }
        }
    }
}
