//
//  MemorizeApp.swift
//  Memorize
//
//  Created by Adelaide Jia on 2024/11/27.
//

import SwiftUI

@main
struct MemorizeApp: App {
    @StateObject var game = EmojiMemoryGame()
    
    var body: some Scene {
        WindowGroup {
            EmojiMemoryGameView(viewModel: game)
        }
    }
}
