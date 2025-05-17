//
//  CardView.swift
//  SoloSet
//
//  Created by Wombat on 5/7/25.
//
import SwiftUI

struct CardView : View
{
    let card: SetGame.Card
    @State private var pulse = false
    
    init(_ card: SetGame.Card)
    {
        self.card = card
    }
    
    var body: some View
    {
        TimelineView(.animation(minimumInterval: 1/5))
        {
            timeline in
            GeometryReader
            {
                geometry in
                ZStack {
                    if card.isFaceUp
                    {
                        cardContents(for: geometry.size.height)
                    }
                    else
                    {
                        Color.clear
                    }
                }.cardify(isFaceUp: card.isFaceUp, dashedBorder: card.exists == false)
                   
                    
            }
        }
    }
    
    private func cardContents(for totalHeight: CGFloat) -> some View
    {
        VStack(spacing: 5)
        {
            let verticalPadding: CGFloat = 15
            let availableHeight = totalHeight - (2 * verticalPadding)
            let shapeHeight = availableHeight / 3.0
            
            ForEach(0..<card.cardCount, id: \.self)
            {
                _ in
                
                CardContent
                    .frame(height: shapeHeight)
            }
        }.padding(15)
        
    }
    
    @ViewBuilder
    var CardContent: some View
    {
        if (card.cardShape == CardShape.diamond)
        {
            applyCardStyle(shape: Diamond())
        }
        else if (card.cardShape == CardShape.oval)
        {
            applyCardStyle(shape: Circle())
        }
        else if (card.cardShape == CardShape.squiggle)
        {
            applyCardStyle(shape: Rectangle())
        }
    }
    
    
    
    @ViewBuilder
    func applyCardStyle(shape: some Shape) -> some View
    {
        ZStack
        {
            if (card.cardShading == CardShading.open)
            {
                shape.stroke().foregroundColor(card.cardColor.swiftUIColor)
            }
            else if (card.cardShading == CardShading.solid)
            {
                shape.fill(card.cardColor.swiftUIColor)
            }
            else if (card.cardShading == CardShading.striped)
            {
                StripeView(color: card.cardColor.swiftUIColor, shape: shape)
            }
            
        }
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        VStack
        {
            CardView(SetGame.Card(isFaceUp: false, cardColor: CardColor.red, cardShape: CardShape.oval, cardShading: CardShading.striped, cardCount: 2,exists: true, id: "test1")).padding(5)
            CardView(SetGame.Card(isFaceUp: true, cardColor: CardColor.red, cardShape: CardShape.oval, cardShading: CardShading.solid, cardCount: 3, exists: true, id: "test1")).padding(5)
            CardView(SetGame.Card(cardColor: CardColor.red, cardShape: CardShape.oval, cardShading: CardShading.striped, cardCount: 1, exists: false, id: "test1")).padding(5).border(.black)
        }
    }
}

extension CardColor
{
    var swiftUIColor: Color {
        switch self {
        case .red:
            return .red
        case .green:
            return .green
        case .blue:
            return .blue
        }
    }
}


struct Diamond: Shape {
    func path(in rect: CGRect) -> Path
    {
        var p = Path()
        p.move(to: CGPoint(x: rect.midX, y: rect.minY))
        p.addLine(to: CGPoint(x: rect.maxX, y: rect.midY))
        p.addLine(to: CGPoint(x: rect.midX, y: rect.maxY))
        p.addLine(to: CGPoint(x: rect.minX, y: rect.midY))
        p.addLine(to: CGPoint(x: rect.midX, y: rect.minY))
        return p
    }
}
