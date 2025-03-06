//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Adelaide Jia on 2024/12/07.
//

import Foundation

class SetGameViewmodel: ObservableObject {
    @Published private var viewModel = createSetGame()
    private var initialCardNumber = 12
    private(set) var presentCardNumber: Int
    
    init() {
        presentCardNumber = initialCardNumber
    }
    
    private static func createSetGame() -> SetGameModel {
      return SetGameModel()
    }
    
    typealias Card = SetGameModel.Card
    
    var cards: [Card] {
        if viewModel.cards.count >= presentCardNumber {
            return Array(viewModel.cards[0..<presentCardNumber])
        } else {
            return viewModel.cards
        }
    }
    func choose(_ card: Card) {
        viewModel.choose(card)
    }
    
    var chosenCards: [Card] {
        return viewModel.chosenCards
    }
}
