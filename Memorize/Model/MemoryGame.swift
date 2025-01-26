//
//  MemorizeGame.swift
//  Memorize
//
//  Created by Adelaide Jia on 2024/12/06.
//

import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable{
    private(set) var cards: Array<Card>
    private(set) var scores : Int = 0
    
    init(numberOfPairsOfCards: Int, cardContentFactory: (Int) -> CardContent) {
        cards = Array<Card>()
        for pairIndex in 0..<max(2, numberOfPairsOfCards) {
            let content: CardContent = cardContentFactory(pairIndex)
            cards.append(Card(content: content, id: "\(pairIndex+1)a"))
            cards.append(Card(content: content, id: "\(pairIndex+1)b"))
        }
        cards.shuffle()
    }
    
    var indexOfTheOneAndOnlyFaceUpCard: Int? {
        get { cards.indices.filter { index in cards[index].isFaceUp }.only}
        set { cards.indices.forEach { cards[$0].isFaceUp = (newValue == $0) } }
    }
    
    mutating func choose(_ card: Card) {
        if let chosenIndex = cards.firstIndex(where: {$0.id == card.id }) {
            //查找index，确保用户点击的卡片存在于游戏中
            if !cards[chosenIndex].isFaceUp && !cards[chosenIndex].isMatched {
                //避免用户重复点击同一张卡片，或者点击已经匹配完成的卡片
                if let potentialMatchIndex = indexOfTheOneAndOnlyFaceUpCard {
                    //检查当前是否已经有一张翻开的卡片
                    if cards[chosenIndex].content == cards[potentialMatchIndex].content {
                        cards[chosenIndex].isMatched = true
                        cards[potentialMatchIndex].isMatched = true
                        scores += 2
                    } else if cards[chosenIndex].hasSeen == true {scores -= 1}
                   // 有两张未匹配但是看过-1
                } else {
                    indexOfTheOneAndOnlyFaceUpCard = chosenIndex
                    //如果没有唯一翻开的卡片，设置当前卡片为唯一翻开的卡片
                    if cards[chosenIndex].hasSeen == true {scores -= 1}
                    // 只有一张但是已经看过-1
                }
                cards[chosenIndex].isFaceUp = true
                cards[chosenIndex].hasSeen = true
            }
        }
    }
    
    mutating func shuffle() {
        cards.shuffle()
    }
    
    struct Card: Equatable, Identifiable, CustomDebugStringConvertible {
        var debugDescription: String {
            "\(id): \(content)"
        }
        var isFaceUp = false
        var isMatched = false
        var content: CardContent
        var id: String
        var hasSeen = false
    }
}

extension Array {
    var only: Element? {
        count == 1 ? first : nil
    }
}
