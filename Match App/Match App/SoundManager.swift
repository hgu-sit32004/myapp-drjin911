//
//  SoundManager.swift
//  Match App
//
//  Created by student24 on 2018. 6. 11..
//  Copyright © 2018년 student24. All rights reserved.
//

import Foundation
import AVFoundation

class SoundManager {
    
    static var audioPlayer: AVAudioPlayer?
    
    enum SoundEffect {
        
        case flip
        case shuffle
        case nomatch
        case match
        
    }
    
    static func playSound(_ effect:SoundEffect){
        
        var soundFilename = ""
        
        //Determine which sound effect we want to play
        // and set the appropriate switch
        switch effect {
            
        case .flip:
            soundFilename = "cardflip"
            
        case .shuffle:
            soundFilename = "shuffle"
            
        case .match:
            soundFilename = "dingcorrect"
            
        case .nomatch:
            soundFilename = "dingwrong"
        }
        
        
        // Get the path to the sound file inside the bundle
        let bundlePath = Bundle.main.path(forResource: soundFilename, ofType: "wav")
        
        guard bundlePath != nil else {
            print("Coudn't find sound file \(soundFilename) in the bundle")
            return
        }
        // create a url object from thiis sting path
        let soundURL = URL(fileURLWithPath: bundlePath!)
        
        do{
            //Create audio player object
            audioPlayer = try AVAudioPlayer(contentsOf: soundURL)
            
            //play the sound
            audioPlayer?.play()
        }
        catch {
            // Coudn't create audio player object, log the error
            
            print("Coudn't create the audio player object for soundfile \(soundFilename)")
            
        }
        
    }
    
}
