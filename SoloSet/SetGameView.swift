//
//  ContentView.swift
//  SoloSet
//
//  Created by Wombat on 5/6/25.
//

import SwiftUI

struct SetGameView: View
{
    @ObservedObject var viewModel: SetGameViewModel
    private let cardAspectRatio: CGFloat = 2/3
    
    var body: some View
    {
        VStack {
            //cards.animation(.default, value: viewModel.cards)
            //ScrollView
            
            cards
            
            Spacer()
            Button("Draw")
            {
                viewModel.draw()
            }.disabled(viewModel.deckEmpty)
            Button("New Game")
            {
                viewModel.newGame()
            }
        }
        .padding()
    }
    
    var cards: some View
    {
        AspectVGrid(viewModel.cards, aspectRatio: cardAspectRatio)
        {
            card in
            CardView(card)
                
                .padding(4)
                .onTapGesture
                {
                    viewModel.choose(card)
                }
                .foregroundColor(card.setStatus == CardStatus.set ? .green : (card.setStatus == CardStatus.not_set ? .red : (card.isSelected ? .yellow : .black)))
                
        }
        
    }
}




#Preview {
    SetGameView(viewModel: SetGameViewModel())
}
