//ModelView
//  EmojiMemoryGame.swift
//  Memorize_e
//
//  Created by Eric Eaton on 12/3/21.
//

/*
 THIS ENABLES COMMUNICATION BETWEEN MODEL AND VIEW
 
 Initializes a MemoryGame Object
 
 
 */


import Foundation

class EmojiMemoryGame: ObservableObject {
    
    static let emojis = ["ðĶ", "ðĶ", "ðī", "ðĶ", "ð", "ð", "ðĶ", "ðĶ", "ðĶĒ", "ð", "ð", "ð","ðĶ", "ð", "ðģ", "ðĶ","ð", "ðĶĻ", "ðĶĶ", "ðĶ"]
    
    static func createMemoryGame() -> MemoryGame<String>{
        MemoryGame<String>(numberOfPairsOfCards: 10, createCardContent: {
                (pairIndex:Int) -> String in
                EmojiMemoryGame.emojis[pairIndex]
            })
    }
    
    @Published private(set) var model = createMemoryGame()
    
    func choose(_ card: MemoryGame<String>.Card) {
        // this method, from MemoryGame struct, is called when a specific card is selected on UI.
        model.choose(card)
    }
    
}
