//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Adelaide Jia on 2024/12/07.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    private static var themeArray : Array<Theme> = [
        Theme(name: "weather", emojisTheme: ["☀️", "🌤", "⛅", "🌧", "🌩", "❄️", "🌪", "🌈", "🌫", "☔"], numberOfPairsOfCards: 5, color: "yellow"),
        Theme(name: "sport", emojisTheme: ["⚽", "🏀", "🏈", "⚾", "🎾", "🏐", "🎳", "⛳", "🏸", "🥋"], numberOfPairsOfCards: 6, color: "blue"),
        Theme(name: "nature", emojisTheme: ["🌲", "🌳", "🌴", "🌵", "🌿", "☘️", "🍀", "🍂", "🍁", "🌾"] , numberOfPairsOfCards: 7, color: "green"),
        Theme(name: "objects", emojisTheme: ["📱", "💻", "📷", "🎥", "📖", "✏️", "🎨", "🎵", "🎮", "🔑"], numberOfPairsOfCards: 8, color: "black"),
        Theme(name: "animals", emojisTheme: ["🐶", "🐱", "🦁", "🐯", "🐻", "🐼", "🐨", "🐸", "🐵", "🦊"], numberOfPairsOfCards: 9, color: "orange"),
        Theme(name: "activities", emojisTheme: ["🎨", "🎭", "🎤", "🎸", "🎹", "🎻", "🎯", "🎮", "🎲", "🎳"] , numberOfPairsOfCards: 10, color: "purple")
    ]
    private static func random() -> Int {
        return Int.random(in: 0..<themeArray.count)
    }
    
    @Published private(set) var theme: Theme
    @Published private var model : MemoryGame<String>
    
    init() {
        guard !Self.themeArray.isEmpty else {
            fatalError("themeArray can be empty")
        }
        let randomTheme = Self.themeArray[EmojiMemoryGame.random()]
        self.theme = randomTheme
        self.model = Self.createMemoryGame(with: randomTheme)
    }
    
    var color: Color {
        switch theme.color {
        case "yellow": return .yellow
        case "blue": return .blue
        case "green": return .green
        case "black": return .black
        case "orange": return .orange
        case "purple": return .purple
        default: return .brown
        }
    }
    
    private static func createMemoryGame(with theme: Theme) -> MemoryGame<String> {
        let emojis = theme.emojisTheme.shuffled()
        return MemoryGame<String>(
            numberOfPairsOfCards: theme.numberOfPairsOfCards
        ) { pairIndex in
            if emojis.indices.contains(pairIndex) {
                emojis[pairIndex]
            } else {
                "?!"
            }
        }
    }

    var cards: Array<MemoryGame<String>.Card> {
        return model.cards
    }
    
    var scores: Int {
        return model.scores
    }
    // MARK: - Intents
    func newGame() {
        let newTheme = Self.themeArray[EmojiMemoryGame.random()]
        theme = newTheme
        model = EmojiMemoryGame.createMemoryGame(with: newTheme)
    }
    
    func choose(_ card: MemoryGame<String>.Card) {
        model.choose(card)
    }
}
