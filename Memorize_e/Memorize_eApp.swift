//
//  Memorize_eApp.swift
//  Memorize_e
//
//  Created by Eric Eaton on 12/2/21.
//

import SwiftUI

@main
struct Memorize_eApp: App {
    let game = EmojiMemoryGame()
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: game)
        }
    }
}
