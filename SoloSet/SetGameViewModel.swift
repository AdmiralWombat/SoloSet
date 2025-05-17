//
//  SetGameViewModel.swift
//  SoloSet
//
//  Created by Wombat on 5/6/25.
//

import SwiftUI

class SetGameViewModel : ObservableObject
{
    @Published private var setGameModel : SetGame
    
    init()
    {
        self.setGameModel = SetGameViewModel.createSetGame()
    }
    
    static func createSetGame() -> SetGame
    {
        return SetGame()
    }
    
    var cards: Array<SetGame.Card>
    {
        return setGameModel.boardCards
    }
    
    var deck: Array<SetGame.Card>
    {
        return setGameModel.deck
    }
    
    var discardPile: Array<SetGame.Card>
    {
        return setGameModel.discardPile
    }
    
    var deckEmpty: Bool
    {
        return setGameModel.deck.isEmpty
    }
    
    func newGame()
    {
        setGameModel.newGame()
    }
    
    func shuffle()
    {
        setGameModel.shuffle()
    }
    
    func flipCards()
    {
        setGameModel.flipCards()
    }
    
    func draw()
    {
        setGameModel.draw()
    }
    
    func choose(_ card: SetGame.Card)
    {
        setGameModel.choose(card: card)
    }
}
