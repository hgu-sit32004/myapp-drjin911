//
//  CardModel.swift
//  Match App
//
//  Created by student24 on 2018. 6. 9..
//  Copyright © 2018년 student24. All rights reserved.
//

import Foundation

class CardModel {
    
    
    func getCards() -> [Card] {
        
        // Declare an array to store numbers we've already generated
        var generatedNumbersArray = [Int]()
        
        // Declare an array to stroe the generated cards
        var generatedCardsArray = [Card]()
    
        
        // Randomly generate pairs of cards
        while generatedNumbersArray.count < 8 {
            
            // Get a random number
            let randomNumber = arc4random_uniform(13) + 1
            
            //Ensure that the random number isn't one we already have
            if generatedNumbersArray.contains(Int(randomNumber)) == false {
                
                // Log the number
                print("generating a random number \(randomNumber)")
                
                //Store the number into the generated Numbers array
                generatedNumbersArray.append(Int(randomNumber))
                
                
                // Create the first card object
                let cardOne = Card()
                cardOne.imageName = "card\(randomNumber)"
                
                generatedCardsArray.append(cardOne)
                
                //Create the second card object
                let cardTwo = Card()
                cardTwo.imageName = "card\(randomNumber)"
                
                generatedCardsArray.append(cardTwo)

            }
        }
        
        // Randomize the array
        for i in 0...generatedCardsArray.count-1 {
            //Find a random index to swap path
            let randomNumber = Int(arc4random_uniform(UInt32(generatedCardsArray.count)))
        // Swap the two cards
            let temporaryStorage = generatedCardsArray[0]
            generatedCardsArray[0] = generatedCardsArray[randomNumber]
            generatedCardsArray[randomNumber] = temporaryStorage
        }
        
        print(generatedCardsArray.count)
        
        // Returen the array
        return generatedCardsArray
    }
    
    
}

//I AM DONE!!!!



