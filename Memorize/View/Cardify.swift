//
//  Cardify.swift
//  Memory03
//
//  Created by Adelaide Jia on 2025/03/05.
//

import SwiftUI

struct Cardify: ViewModifier {
    var isSelected: Bool
    var isMatched: Bool
    var isFaceUp: Bool {
        rotation < 90
    }
    var rotation: Double
    
    var animatableData: Double {
        get { rotation }
        set { rotation = newValue }
    }
    
    init(isFaceUp: Bool, isSelected: Bool, isMatched: Bool) {
        rotation = isFaceUp ? 0 : 180
        self.isSelected = isSelected
        self.isMatched = isMatched
    }
    
    func body(content: Content) -> some View {
        GeometryReader { geometry in
            ZStack {
                let base = RoundedRectangle(cornerRadius: Constants.roundingRatio * geometry.size.width)
                base.strokeBorder(lineWidth: Constants.lineWidthRatio * geometry.size.width)
                    .background(base.fill(.white))
                    .shadow(
                        color: isSelected ? .accentColor : .clear,
                        radius: isSelected ? Constants.shadowRadiusRatio * geometry.size.width : 0
                    )
                    .overlay(
                        content
                    )
                    .opacity(isFaceUp ? 1 : 0)
                base.fill()
                    .opacity(isFaceUp ? 0 : 1)
            }
            .rotation3DEffect(.degrees(rotation), axis: (0, 1, 0))
            .rotation3DEffect(.degrees(isSelected ? 10 : 0), axis: (-1, 0, 0))
        }
    }
    
    private struct Constants {
        static let lineWidthRatio: Double = 0.01
        static let aspectRatio: CGFloat = 2
        static let roundingRatio: Double = 0.175
        static let spacingRatio: Double = 0.1
        static let shadowRadiusRatio: Double = 0.05
    }
}

extension View {
    func cardify(isFaceUp: Bool, isSelected: Bool, isMatched: Bool) -> some View {
        modifier(
            Cardify(
                isFaceUp: isFaceUp,
                isSelected: isMatched,
                isMatched: isMatched
            )
        )
    }
}
