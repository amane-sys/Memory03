//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by Adelaide Jia on 2024/12/07.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    @ObservedObject var viewModel: EmojiMemoryGame
    
    var body: some View {
        VStack(spacing: 10) {
            ScrollView {
                cards
                    .animation(.default, value: viewModel.cards)
            }
            Button("New Game") {
                viewModel.newGame()
            }.font(.system(size: 25))
            
            HStack(spacing: 20) {
                Text("Theme is : \(viewModel.theme.name)").bold()
                Text("Scores :")
                Text("\(viewModel.scores)")
                    .foregroundColor(viewModel.scores >= 0 ? .green : .red)
            }.font(.system(size: 20))
        }
        .padding()
    }
    var cards: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 85), spacing: 0)], spacing: 0) {

            ForEach(viewModel.cards) { card in
                CardView(card)
                    .aspectRatio(2/3, contentMode: .fit)
                    .padding(4)
                    .onTapGesture {
                        viewModel.choose(card)
                    }
            }
            
        }.foregroundColor(viewModel.color)
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
