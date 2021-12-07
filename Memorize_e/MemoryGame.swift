//Model
//  MemoryGame.swift
//  Memorize_e
//
//  Created by Eric Eaton on 12/3/21.
//

/*THIS IS THE STRUCTURE/LOGIC OF THE GAME
 -STRUCTURE
 What is a card
 What characteristics does a card have
 How are the cards grouped
 How is the structure of cards initialized and what information is required
 
 
 -LOGIC
 how are the cards selected by a player
 what happens when a card is selected
 what happens when two cards are matched
 what happens when two cards are selected but not matched
 how is score kept
 
 
 
 */

import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable {
    
    struct Card: Identifiable {
        var id: Int
    
        // representation of a card
        var isFaceUp: Bool = false
        var matched: Bool = false
        var content: CardContent  // has property that represents the content on the card
        /* CardContent is a generic type, and represents what will be on the card,
          this will be set when initializing a MemoryGame object
            -this could be a String (like in our case of emoji), or image, or whatever*/
    }
    
    private var indexOfFirstSelectedCard: Int?
    private var indexOfSecondSelectedCard: Int?
    
    var cards: Array<Card>  // an array used to hold cards
    
    
    init(numberOfPairsOfCards: Int, createCardContent: (Int) -> CardContent) {
        cards = Array<Card>()  // initialize the card container
        for pairIndex in 0..<numberOfPairsOfCards {
            //
            let cardContent: CardContent = createCardContent(pairIndex)
            cards.append(Card(id: pairIndex*2, content: cardContent))
            cards.append(Card(id: pairIndex*2+1, content: cardContent))

        }
    }
    
    func index(of card:Card) -> Int {
        for index in 0..<cards.count {
            if cards[index].id == card.id {
                return index
            }
        }
        return 0
    }
    
    mutating func choose(_ card: Card) {
        //I can double click a card and it acts like a match -> block clicking a face up card
        
        // get the cards index in the array
        let chosenIndex = cards.firstIndex(where: {cardInTheArray in cardInTheArray.id == card.id})!
        // disable clicking a faceup card or card that is matched
        if !cards[chosenIndex].isFaceUp && !cards[chosenIndex].matched {
            // case 1: all cards are face down
            if indexOfFirstSelectedCard == nil {
                indexOfFirstSelectedCard = chosenIndex
                cards[chosenIndex].isFaceUp.toggle()
            }
            // case 2: one card is face up
            else if indexOfFirstSelectedCard != nil && indexOfSecondSelectedCard == nil {
                indexOfSecondSelectedCard = chosenIndex
                cards[chosenIndex].isFaceUp.toggle()
                // logic check on if cards match
                if cards[indexOfFirstSelectedCard!].content == cards[indexOfSecondSelectedCard!].content {
                    cards[indexOfFirstSelectedCard!].matched = true
                    cards[indexOfSecondSelectedCard!].matched = true
                }
            }
            // case 3: two cards are face up and do not match
            else {
                cards[indexOfFirstSelectedCard!].isFaceUp = false
                cards[indexOfSecondSelectedCard!].isFaceUp = false
                indexOfFirstSelectedCard = chosenIndex
                indexOfSecondSelectedCard = nil
                cards[chosenIndex].isFaceUp.toggle()
            }
        }
        


        


        

        
        
    }

}
