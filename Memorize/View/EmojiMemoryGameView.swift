//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by Adelaide Jia on 2024/12/07.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    @ObservedObject var viewModel: EmojiMemoryGame
    private let aspectRatio: CGFloat = 2/3
    
    var body: some View {
        VStack() {
            VStack {
                cards
                    .animation(.default, value: viewModel.cards)
                Button("Shuffle") {
                    viewModel.shuffle()
                }
            }
        }
        .padding()
    }
    private var cards: some View {
        AspectVGrid() { card in
            CardView(card)
                .padding(5)
                .onTapGesture {
                    viewModel.choose(card)
                }
        }
        .foregroundColor(Color.orange)
    }
}

struct CardView: View {
    let card: MemoryGame<String>.Card
    
    init(_ card: MemoryGame<String>.Card) {
        self.card = card
    }
    
    var body: some View {
        ZStack {
            let base = RoundedRectangle(cornerRadius: 12)
            Group {
                base.fill(.white)
                base.strokeBorder(lineWidth: 2)
                Text(card.content)
                    .font(.largeTitle)
                    .minimumScaleFactor(0.01)
                    .aspectRatio(contentMode: .fit)
            }
            .opacity(card.isFaceUp ? 1 : 0)
            // if faceUp is false than the card is backface
            base.fill()
                .opacity(card.isFaceUp ? 0 : 1)
        }
        // if already matched it will disappear
        .opacity(!card.isFaceUp && card.isMatched ? 0 : 1)//？？
    }
}

#Preview {
    EmojiMemoryGameView(viewModel: EmojiMemoryGame())
}
