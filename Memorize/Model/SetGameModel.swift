//
//  MemorizeGame.swift
//  Memorize
//
//  Created by Adelaide Jia on 2024/12/06.
//

import Foundation

struct SetGameModel {
    private(set) var cards = createCard()

    
    static private func createCard(shuffled: Bool = true) -> [Card] {
        var cards: [Card] = []
        for number in NumberOfShapes.allCases {
            for type in TypeofShapes.allCases {
                for shading in Shading.allCases {
                    for color in ShapeColor.allCases {
                        cards.append(Card(number, type, shading, color))
                    }
                }
            }
        }
        
        return shuffled ? cards.shuffled() : cards
    }
    
    struct Card: Identifiable, Equatable, CustomDebugStringConvertible {

        let number: NumberOfShapes
        let typeOfShape: TypeofShapes
        let shading: Shading
        let color: ShapeColor
        
        var isChosen: Bool = false
        var isMatched: Bool = false
        var isFaceUp: Bool = false
        
        init(
            _ number: NumberOfShapes,
            _ typeOfShape: TypeofShapes,
            _ shading: Shading,
            _ color: ShapeColor,
            isFaceUp: Bool = false
        ) {
            self.number = number
            self.typeOfShape = typeOfShape
            self.shading = shading
            self.color = color
            self.isFaceUp = isFaceUp
        }
        
        var id: String {
            "[\(number)-\(typeOfShape)-\(shading)-\(color)]"
        }
        
        var n : Int {
            switch number {
            case .one:
                return 1
            case .two:
                return 2
            case .three:
                return 3
            }
        }
        var debugDescription: String {
            return id
        }
    }
    
}
