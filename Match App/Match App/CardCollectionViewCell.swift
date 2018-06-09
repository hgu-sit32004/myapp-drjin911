//
//  CardCollectionViewCell.swift
//  Match App
//
//  Created by student24 on 2018. 6. 9..
//  Copyright © 2018년 student24. All rights reserved.
//

import UIKit

class CardCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var frontImageView: UIImageView!
    
    @IBOutlet weak var backImageView: UIImageView!
    
    var card : Card?
    
    func sestCard( _ card:Card) {
        
        // Keep track of the card that gets passed in
        self.card = card
        
        if card.isMatched == true {
            
            
        }
    }
    
}
