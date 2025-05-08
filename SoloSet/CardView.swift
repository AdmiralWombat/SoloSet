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
                base.strokeBorder(lineWidth: 2)
                VStack
                {
                    ForEach(0..<card.cardCount, id: \.self)
                    { _ in
                    
                        CardContent
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
                shape.fill(card.cardColor.swiftUIColor)
               
            }
            
        }
    }
    
}


extension CardColor
{
    var swiftUIColor: Color {
        switch self {
        case .red:
            return .red
        case .yellow:
            return .yellow
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