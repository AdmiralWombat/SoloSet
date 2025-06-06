//
//  SetModel.swift
//  SoloSet
//
//  Created by Wombat on 5/6/25.
//

import Foundation

enum CardStatus
{
    case none, set, not_set
}

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
    private(set) var discardPile: Array<Card>
    
    init()
    {
        deck = []
        boardCards = []
        discardPile = []
        
        newGame()
    }
    
    mutating func newGame()
    {
        deck = []
        boardCards = []
        discardPile = []
        
        for shape in CardShape.allCases
        {
            for color in CardColor.allCases
            {
                for shading in CardShading.allCases
                {
                    for count in 1..<4
                    {
                        let cardId = "\(shape) \(color) \(shading) \(count)"
                        deck.append(Card(cardColor: color, cardShape: shape, cardShading: shading, cardCount: count, exists: true, id: cardId))
                    }
                }
            }
        }
        deck.shuffle()
        
        for _ in 0..<12
        {
            drawCard()
        }
    }
    
    mutating func shuffle()
    {
        boardCards.shuffle()
    }
    
    mutating func flipCards()
    {
        for index in boardCards.indices
        {
            boardCards[index].isFaceUp.toggle()
        }
    }
    
    mutating func draw()
    {
        if (indexOfSelected.count == 3)
        {
            let sortedIndex = indexOfSelected.sorted(by: >)
        
            let indexCard1 = sortedIndex[0]
            let indexCard2 = sortedIndex[1]
            let indexCard3 = sortedIndex[2]
            
            if (determineMatch(index1: indexCard1, index2: indexCard2, index3: indexCard3))
            {
                drawCard(replaceIndex: indexCard1)
                drawCard(replaceIndex: indexCard2)
                drawCard(replaceIndex: indexCard3)
            }
        }
        else
        {
            for _ in 0..<3
            {
                drawCard()
            }
        }
    }
    
    mutating func choose(card: Card)
    {
        if let chosenIndex = boardCards.firstIndex(where: { $0.id == card.id })
        {
            if (indexOfSelected.count == 3)
            {
                let sortedIndex = indexOfSelected.sorted(by: >)
            
                let indexCard1 = sortedIndex[0]
                let indexCard2 = sortedIndex[1]
                let indexCard3 = sortedIndex[2]
                
                if (determineMatch(index1: indexCard1, index2: indexCard2, index3: indexCard3))
                {
                    if (!boardCards[chosenIndex].isSelected)
                    {
                        indexOfSelected.append(chosenIndex)
                    }
                    boardCards[indexCard1].reset()
                    boardCards[indexCard2].reset()
                    boardCards[indexCard3].reset()
                    
                    discardCard(cardIndex: indexCard1)
                    discardCard(cardIndex: indexCard2)
                    discardCard(cardIndex: indexCard3)
                }
                else
                {
                    boardCards[indexCard1].reset()
                    boardCards[indexCard2].reset()
                    boardCards[indexCard3].reset()
                    
                    indexOfSelected.append(chosenIndex)
                }
            }
            else
            {
                if (boardCards[chosenIndex].isSelected)
                {
                    boardCards[chosenIndex].reset()
                }
                else
                {
                    indexOfSelected.append(chosenIndex)
                    
                    if (indexOfSelected.count == 3)
                    {
                        let indexCard1 = indexOfSelected[0]
                        let indexCard2 = indexOfSelected[1]
                        let indexCard3 = indexOfSelected[2]
                        if (determineMatch(index1: indexCard1, index2: indexCard2, index3: indexCard3))
                        {
                            boardCards[indexCard1].setStatus = CardStatus.set
                            boardCards[indexCard2].setStatus = CardStatus.set
                            boardCards[indexCard3].setStatus = CardStatus.set
                        }
                        else
                        {
                            boardCards[indexCard1].setStatus = CardStatus.not_set
                            boardCards[indexCard2].setStatus = CardStatus.not_set
                            boardCards[indexCard3].setStatus = CardStatus.not_set
                        }
                    }
                }
            }
            
        }
    }
    
    private mutating func drawCard(replaceIndex: Int = -1)
    {
        if (!deck.isEmpty)
        {
            if (replaceIndex == -1)
            {
                var tempCard = deck.remove(at: deck.count - 1)
                tempCard.isFaceUp = true
                boardCards.append(tempCard)
            }
            else
            {
                discardPile.append(boardCards[replaceIndex])
                var tempCard = deck.remove(at: deck.count - 1)
                tempCard.isFaceUp = true
                boardCards[replaceIndex] = tempCard
            
            }
            
        }
    }
    
    private mutating func discardCard(cardIndex: Int)
    {
        discardPile.append(boardCards[cardIndex])
        boardCards.remove(at: cardIndex)
    }
    
    private func determineMatch(index1 : Int, index2 : Int, index3: Int) -> Bool
    {
        let card1 = boardCards[index1]
        let card2 = boardCards[index2]
        let card3 = boardCards[index3]
        
        let colorSet = (card1.cardColor == card2.cardColor && card2.cardColor == card3.cardColor) || (card1.cardColor != card2.cardColor && card1.cardColor != card3.cardColor && card2.cardColor != card3.cardColor)
        let shapeSet = (card1.cardShape == card2.cardShape && card2.cardShape == card3.cardShape) || (card1.cardShape != card2.cardShape && card1.cardShape != card3.cardShape && card2.cardShape != card3.cardShape)
        let countSet = (card1.cardCount == card2.cardCount && card2.cardCount == card3.cardCount) || (card1.cardCount != card2.cardCount && card1.cardCount != card3.cardCount && card2.cardCount != card3.cardCount)
        let shadingSet = (card1.cardShading == card2.cardShading && card2.cardShading == card3.cardShading) || (card1.cardShading != card2.cardShading && card1.cardShading != card3.cardShading && card2.cardShading != card3.cardShading)
        return colorSet && shapeSet && countSet && shadingSet
        
    }
    
    
    
    var indexOfSelected: Array<Int>
    {
        get
        {
            return boardCards.indices.filter { index in boardCards[index].isSelected }
        }
        set
        {
            for cardIndex in boardCards.indices
            {
                if (newValue.contains(cardIndex))
                {
                    boardCards[cardIndex].isSelected = true
                }
            }
        }
    }
    
    struct Card : Equatable, Identifiable, CustomDebugStringConvertible
    {
        var setStatus: CardStatus = CardStatus.none
        var isSelected = false
        var isFaceUp = false
        let cardColor: CardColor
        let cardShape: CardShape
        let cardShading: CardShading
        let cardCount: Int
        let exists: Bool
        
        var debugDescription: String
        {
            "\(cardCount), \(cardColor), \(cardShape), \(cardShading)"
        }
        
        mutating func reset()
        {
            setStatus = CardStatus.none
            isSelected = false
        }
        
        var id: String
    }
    
    
}
