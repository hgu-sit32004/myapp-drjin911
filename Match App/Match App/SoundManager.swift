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
    
    var audioPlayer: AVAudioPlayer?
    
    enum SoundEffect {
        
        case flip
        case shuffle
        case nomatch
        case match
        
    }
    
    func playSound(_ effect:SoundEffect){
        
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
        
    }
    
}
