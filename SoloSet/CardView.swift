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
    
    init(_ card: SetGame.Card)
    {
        self.card = card
    }
    
    var body: some View
    {
        ZStack()
        {
            let base = RoundedRectangle(cornerRadius: 12)
            Group
            {
                base.foregroundColor(.white)
                base.strokeBorder(lineWidth: card.isSelected ? 6 : 2)
                VStack
                {
                    ForEach(0..<card.cardCount, id: \.self)
                    { _ in
                    
                        CardContent.aspectRatio(2, contentMode: .fit )
                    }
                }.padding(15)
            }
            .opacity(1)
            base.fill().opacity(0)
            
        }
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
                //shape.fill(card.cardColor.swiftUIColor.opacity(0.5))
                StripeView(color: card.cardColor.swiftUIColor, shape: shape)
            }
            
        }
    }
    
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        VStack
        {
            CardView(SetGame.Card(cardColor: CardColor.red, cardShape: CardShape.squiggle, cardShading: CardShading.striped, cardCount: 1, id: "test1")).padding(5)
            CardView(SetGame.Card(cardColor: CardColor.red, cardShape: CardShape.squiggle, cardShading: CardShading.striped, cardCount: 1, id: "test1")).padding(5)
            CardView(SetGame.Card(cardColor: CardColor.red, cardShape: CardShape.squiggle, cardShading: CardShading.striped, cardCount: 3, id: "test1")).padding(5)
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
