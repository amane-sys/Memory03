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
    
    mutating func newGame() {
        cards.shuffle()
    }
    var chosenCards: [Card] {
        cards.filter { $0.isChosen }
    }
    
    var chosenIndices: [Int] {
        chosenCards.map { card in cards.firstIndex(of: card)! }
    }
    
    mutating func choose(_ card: Card) {
        print("User chose card \(card)")
        if let chosenIndex = cards.firstIndex(where: { $0.id == card.id }) {
            if chosenCards.count == 3 {
                print("  Three cards were already selected")
                if chosenCards.isSet {
                    print("   Found a complete set!")
                }
            }
            
            if chosenCards.count <= 3, !cards[chosenIndex].isMatched {
                cards[chosenIndex].isChosen.toggle()
                print("Toggled isChosen to \(cards[chosenIndex].isChosen)")
            }
            
            if chosenCards.countIsValid && !chosenCards.isSet {
                chosenCards.printWhyTheSetFailed()
            }
        }
    }
}
extension [SetGameModel.Card] {
    var isSet: Bool {
        return countIsValid && numberCanMakeValidSet && shapeCanMakeValidSet && colorCanMakeValidSet && shadingCanMakeValidSet
    }
    
    var countIsValid: Bool {
        self.count == 3
    }
    
    var numberCanMakeValidSet: Bool {
        Set(self.map { $0.number }).count != 2
    }
    
    var shapeCanMakeValidSet: Bool {
        Set(self.map { $0.shading }).count != 2
    }
    
    var colorCanMakeValidSet: Bool {
        Set(self.map { $0.color }).count != 2
    }
    
    var shadingCanMakeValidSet: Bool {
        Set(self.map { $0.shading }).count != 2
    }
    
    func printWhyTheSetFailed() {
        print("    The selected cards are not a correct set")
        print("      countIsValid = \(countIsValid)")
        print("      numberCanMakeValidSet = \(numberCanMakeValidSet)")
        print("      typeOfShapeCanMakeValidSet = \(shapeCanMakeValidSet)")
        print("      shadingCanMakeValidSet = \(shadingCanMakeValidSet)")
        print("      colorCanMakeValidSet = \(colorCanMakeValidSet)")
    }
}
