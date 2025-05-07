//
//  SetModel.swift
//  SoloSet
//
//  Created by Wombat on 5/6/25.
//

import Foundation

enum CardColor: CaseIterable {
    case red, green, blue
}

enum CardShape: CaseIterable {
    case oval, diamond, squiggle
}

enum CardShading: CaseIterable {
    case solid, striped, open
}

struct SetGame
{
    private(set) var deck: Array<Card>
    private(set) var boardCards: Array<Card>
    
    init()
    {
        deck = []
        boardCards = []
        
        newGame()
    }
    
    mutating func newGame()
    {
        for shape in CardShape.allCases
        {
            for color in CardColor.allCases
            {
                for shading in CardShading.allCases
                {
                    for count in 1..<4
                    {
                        deck.append(Card(cardColor: color, cardShape: shape, cardShading: shading, cardCount: count))
                    }
                }
            }
        }
        deck.shuffle()
        
        for _ in 0..<12
        {
            boardCards.append(deck.remove(at: deck.count - 1))
        }
        
        for card in boardCards
        {
            print (card)
        }
    }
    
    struct Card : CustomDebugStringConvertible
    {
        var isMatch = false
        var isSelected = false
        let cardColor: CardColor
        let cardShape: CardShape
        let cardShading: CardShading
        let cardCount: Int
        
        var debugDescription: String
        {
            "\(cardCount), \(cardColor), \(cardShape), \(cardShading)"
        }
    }
    
    
}
