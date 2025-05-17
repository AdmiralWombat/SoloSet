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
    
    @Namespace private var dealingNamespace
    @Namespace private var discardNamespace
    
    private let cardAspectRatio: CGFloat = 2/3
    private let deckWidth: CGFloat = 50
    
    var body: some View
    {
        VStack {
            //cards.animation(.default, value: viewModel.cards)
            //ScrollView
            
            cards
            
            Spacer()
            HStack
            {
                deck.disabled(viewModel.deckEmpty)
                VStack
                {
                    Button("Shuffle")
                    {
                        shuffle()
                    }
                    
                    Button("New Game")
                    {
                        newGame()
                        
                    }
                    
                    /*Button("Flip")
                    {
                        flip()
                    }*/
                    
                }
                discardPile
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
                    withAnimation(.easeInOut(duration: 1.0))
                    {
                        viewModel.choose(card)
                    }
                }
                .matchedGeometryEffect(id: card.id, in: dealingNamespace)
                .transition(.asymmetric(insertion: .identity, removal: .identity))
                
                .scaleEffect(card.setStatus == .set ? 1.15 : (card.setStatus == .not_set ? 0.9 : 1.0))
                .animation(.easeInOut(duration: 0.25), value: card.setStatus)
                .foregroundColor(card.setStatus == CardStatus.set ? .green : (card.setStatus == CardStatus.not_set ? .red : (card.isSelected ? .yellow : .black)))
                
        }
    }
    
    private var deck: some View
    {
        ZStack
        {
            if (!viewModel.deck.isEmpty)
            {
                ForEach(viewModel.deck)
                {
                    card in
                    CardView(card)
                        .matchedGeometryEffect(id: card.id, in: dealingNamespace)
                        .transition(.asymmetric(insertion: .identity, removal: .identity))
                }
            }
            else
            {
                CardView(SetGame.Card(cardColor: CardColor.red, cardShape: CardShape.oval, cardShading: CardShading.striped, cardCount: 2, exists: false, id: "emptyDeck"))
            }
        }
        .frame(width: deckWidth, height: deckWidth / cardAspectRatio)
        .onTapGesture
        {
            draw()
            
        }
        .foregroundColor(.blue)
    }
    
    private func newGame()
    {
        withAnimation
        {
            viewModel.newGame()
        }
    }
    
    private func flip()
    {
        withAnimation
        {
            viewModel.flipCards()
        }
    }
    
    private func draw()
    {
        withAnimation(.easeInOut(duration: 1))
        {
            
            viewModel.draw()
        }
    }
    
    private func shuffle()
    {
        withAnimation
        {
            viewModel.shuffle()
        }
    }
    
    private var discardPile: some View
    {
        ZStack
        {
            if (viewModel.discardPile.count > 0)
            {
                ForEach(viewModel.discardPile)
                {
                    card in
                    CardView(card)
                        .matchedGeometryEffect(id: card.id, in: dealingNamespace)
                        .transition(.asymmetric(insertion: .identity, removal: .identity))
                }
            }
            else
            {
                CardView(SetGame.Card(cardColor: CardColor.red, cardShape: CardShape.oval, cardShading: CardShading.striped, cardCount: 2, exists: false, id: "emptyDiscard"))
            }
        }
        .frame(width: deckWidth, height: deckWidth / cardAspectRatio)
        .foregroundColor(.blue)
    }
}




#Preview {
    SetGameView(viewModel: SetGameViewModel())
}
