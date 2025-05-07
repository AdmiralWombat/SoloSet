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
}
