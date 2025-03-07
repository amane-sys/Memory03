//
//  CardView.swift
//  Memory03
//
//  Created by Adelaide Jia on 2025/03/04.
//

import SwiftUI

struct CardView: View {
    let card: SetGameModel.Card
    
    init(_ card: SetGameModel.Card) {
        self.card = card
    }
    
    var body: some View {
        shapeStack
            .foregroundColor(color)
            .cardify(
                isFaceUp: true,
                isSelected: card.isChosen,
                isMatched: card.isMatched
                )
    }
    
    private var shapeStack: some View {
        GeometryReader { geometry in
            VStack(spacing: geometry.size.height * Constants.spacingRatio) {
                ForEach(0..<card.n, id: \.self) { _ in
                    shape
                        .aspectRatio(
                            Constants.aspectRatioForShape,
                            contentMode: .fit
                        )
                }
            }
            .frame(maxHeight: .infinity)
            .padding(geometry.size.width * Constants.paddingRatio)
        }
        
    }
    
    @ViewBuilder
    private var shape: some View {
        GeometryReader { geometry in
            switch card.typeOfShape {
            case .diamond:
                Diamond()
                    .stroke(
                        color,
                        lineWidth: shapeStrokeLineWidth(
                            for: card,
                            with: geometry
                        )
                    )
                    .fill(cardFill)
            case .squiggle:
                Squiggle()
                    .stroke(
                        color,
                        lineWidth: shapeStrokeLineWidth(for: card, with: geometry)
                    )
                    .fill(cardFill)
            case .oval:
                Ellipse()
                    .stroke(
                        color,
                        lineWidth: shapeStrokeLineWidth(for: card, with: geometry)
                    )
                    .fill(cardFill)
            }
        }
    }
    private func shapeStrokeLineWidth(for card: SetGameModel.Card, with geometry: GeometryProxy) -> CGFloat {
        (card.shading == .open ? 1.0 : 0.5) * geometry.size.width * Constants.lineWidthRatio
    }
    private var color: Color {
        switch card.color {
        case .red:
            return .red
        case .blue:
            return .blue
        case .yellow:
            return .yellow
        }
    }
    private var cardFill: Color {
        switch card.shading {
        case .solid: color
        case .striped: color.opacity(0.25)
        case .open: Color.white
        }
    }
    
    private struct Constants {
        static let aspectRatioForShape: CGFloat = 2
        static let lineWidthRatio: CGFloat = 0.1
        static let spacingRatio: CGFloat = 0.075
        static let paddingRatio: CGFloat = 0.15
    }
}

#Preview {
    CardView(SetGameModel.Card(.three, .diamond, .open, .blue, isFaceUp: true))
}
