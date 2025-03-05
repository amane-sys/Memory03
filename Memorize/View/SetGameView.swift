//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by Adelaide Jia on 2024/12/07.
//

import SwiftUI

struct SetGameView: View {
    var viewModel: SetGameViewmodel
    private let aspectRatio: CGFloat = 0.75
    
    var body: some View {
        VStack {
            cardView.padding(Constants.paddingAroundCards)
            
            HStack() {
                Button("New Game") {}
                Button("Deal 3 more Cards") {}
            }
        }
    }
    private var cardView : some View {
        AspectVGrid(viewModel.cards, aspectRatio: aspectRatio) { card in
            CardView(card)
                .padding(5)
        }
    }
    private struct Constants {
        static let buttonSpacing: CGFloat = 16
        static let aspectRatio: CGFloat = 2/3
        static let paddingAroundCards: CGFloat = 4
        static let deckAndDiscardWidth: CGFloat = 60
        static let dealInterval: TimeInterval = 0.15
        static let dealAnimation: Animation = .easeInOut(duration: 0.5)
    }
}

#Preview {
    SetGameView(viewModel: SetGameViewmodel())
}
