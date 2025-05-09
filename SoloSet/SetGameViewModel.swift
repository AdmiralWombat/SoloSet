//
//  SetGameViewModel.swift
//  SoloSet
//
//  Created by Wombat on 5/6/25.
//

import SwiftUI

class SetGameViewModel : ObservableObject
{
    @Published private var model : SetGame
    
    init()
    {
        self.model = SetGameViewModel.createSetGame()
    }
    
    static func createSetGame() -> SetGame
    {
        return SetGame()
    }
    
    var cards: Array<SetGame.Card>
    {
        return model.boardCards
    }
    
    var deckEmpty: Bool
    {
        return model.deck.isEmpty
    }
    
    func newGame()
    {
        model.newGame()
   
    }
    
    func draw()
    {
        model.draw()
    }
    
    func choose(_ card: SetGame.Card)
    {
        model.choose(card: card)
    }
}
