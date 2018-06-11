//
//  ViewController.swift
//  Match App
//
//  Created by student24 on 2018. 6. 9..
//  Copyright © 2018년 student24. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var model = CardModel()
    var cardArray = [Card]()
    
    var firstFlippedCardIndex:IndexPath?
    
    var timer:Timer?
    var milliseconds:Float = 30*1000 // 10seconds
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        //Call the getCards method of the card model
        cardArray = model.getCards()

        collectionView.delegate = self
        collectionView.dataSource = self
        
        // Create timer
        timer = Timer.scheduledTimer(timeInterval: 0.001, target: self, selector: #selector(timerElapsed), userInfo: nil, repeats: true)
        
        RunLoop.main.add(timer!, forMode: .commonModes)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        SoundManager.playSound(.shuffle)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    // MARK: - Timer Methods
    
    @objc func timerElapsed(){
        
        milliseconds -= 1
        
        // Converts to seconds
        let seconds = String(format: "% .2f", milliseconds/1000)
        
        //Set label
        timerLabel.text = "Time Remaining: \(seconds)"
        
        // When the timer has reached 0...
        
        if milliseconds <= 0 {
            
            //Stop the timer
            timer?.invalidate()
            timerLabel.textColor = UIColor.red
            
            //Check if there are any cards unmatched
            checkGameEnded()
            
        }
        
    }
    
    
    // MARK: - UICollectionView Protocol Methods
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return cardArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //Get an CardCollectionViewCell object
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CardCell", for: indexPath) as! CardCollectionViewCell
        
        // Get the card that the collection view is trying to display
        let card = cardArray[indexPath.row]
        
        // Set that card for the cell
        cell.setCard(card)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //Check if there's any time left
        if milliseconds <= 0 {
            return
        }
        
        
        // Get the cell that the user selected
        let cell = collectionView.cellForItem(at: indexPath) as! CardCollectionViewCell
        
        //Get the card that the user selected
        let card = cardArray[indexPath.row]
        
        if card.isFlipped == false && card.isMatched == false {
            
            
            
            //Flip the card
            cell.flip()
            
            // play the flip sound
            
            SoundManager.playSound(.flip)
            
            
            //Set the status of the card
            card.isFlipped = true
            
            // Determine if it's the first card or second card tat's flipped over
            
            if firstFlippedCardIndex == nil {
                
                // this is the first card being flipped
                firstFlippedCardIndex = indexPath
            }
                
            else {
                // This is the second card being flipped
                
                // TODO : Perform the matching logic
                checkForMatches(indexPath)
            }
        }
    
        
    } // End the didSelectItemAt method
    
    // Mark : Game logic Methods
    
    func checkForMatches(_ secondFlippedCardIndex:IndexPath){
        //Get the cells for the two cards that were revealed
        let cardOneCell = collectionView.cellForItem(at: firstFlippedCardIndex!) as? CardCollectionViewCell
        
        let cardTwoCell = collectionView.cellForItem(at: secondFlippedCardIndex) as? CardCollectionViewCell
        
        // Get the cards for the tw cards that were revealed
        let cardOne = cardArray[firstFlippedCardIndex!.row]
        let cardTwo = cardArray[secondFlippedCardIndex.row]
        
        //Compare the two cards
        if cardOne.imageName == cardTwo.imageName {
            
            
            // It's a match
            
            
            //Play sound
            
            SoundManager.playSound(.match)
            
            
            
            // Set the statuses of the cards
            cardOne.isMatched = true
            cardTwo.isMatched = true
            // Revmove the cards from the grid
            cardOneCell?.remove()
            cardTwoCell?.remove()
            
            //Check if ther are any cards left unmatched
            
            checkGameEnded()
            
        }
        else {
            
            // It's not a match
            
            //play sound
            
            SoundManager.playSound(.nomatch)
            
            // Set the statuses of the cards
            cardOne.isFlipped = false
            cardTwo.isFlipped = false
            
            // Flip both cards back
            cardOneCell?.flipBack()
            cardTwoCell?.flipBack()
            
        }
        // Tell the collectionview to reload the cell of the first card if it is nill
        if cardOneCell == nil{
            collectionView.reloadItems(at: [firstFlippedCardIndex!])
        }
        
        // Reset the property that tracks the first card flipped
        firstFlippedCardIndex = nil
        
    }
    
    func checkGameEnded(){
        
        //Determine if ther are any cards unmateched
        var isWon = true
        
        for card in cardArray {
            
            if card.isMatched == false{
                isWon = false
                break
            }
        }
        
        // Messaging variables
        var title = ""
        var message = ""
        
        // If not then user has won, stop the timer
        if isWon == true {
            
            
            if milliseconds > 0 {
                timer?.invalidate()
                
            }
            title = "Congratulations!"
            message = "You've WON"
            
        }
        else {
            // If there are unmatched cards, check if ther's any time left

            if milliseconds > 0 {
                return
            }
            
            title = "Game Over"
            message = "You've LOST"
            
        }
        
        // Show won/lost messaging
        showAlert(title, message)
        
    }
    
    func showAlert(_ title:String, _ message:String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        
        alert.addAction(alertAction)
        
        present(alert, animated: true, completion: nil)
    }
    
} // End ViewController class

