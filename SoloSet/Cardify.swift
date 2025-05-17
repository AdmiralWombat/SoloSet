//
//  Cardify.swift
//  Memorize
//
//  Created by Wombat on 5/7/25.
//

import SwiftUI

struct Cardify : ViewModifier, Animatable
{
    init(isFaceUp: Bool, dashedBorder: Bool)
    {
        rotation = isFaceUp ? 0 : 180
        self.dashedBorder = dashedBorder
    }
    
    var isFaceUp: Bool
    {
        rotation < 90
    }
    
    var rotation: Double
    
    let dashedBorder: Bool
    
    var animatableData: Double
    {
        get { rotation }
        set { rotation = newValue }
    }


    func body(content: Content) -> some View
    {
        ZStack() {
            let base = RoundedRectangle(cornerRadius: Constants.cornerRadius)
           
            if (dashedBorder)
            {
                base.stroke(style: StrokeStyle(lineWidth: Constants.lineWidth, dash: [5,5] ))
                    .background(base.fill(.clear))
                    .overlay(content)
            }
            else
            {
                base.strokeBorder(lineWidth: Constants.lineWidth)
                    .background(base.fill(.white))
                    .overlay(content)
                    .opacity(isFaceUp ? 1 : 0)
                
                    base.fill()
                        .opacity(isFaceUp ? 0 : 1)

            }
            
        }
        .rotation3DEffect(.degrees(rotation), axis: (0,1,0))
        
    }
    
    private struct Constants
    {
        static let cornerRadius: CGFloat = 12
        static let lineWidth: CGFloat = 2
        
    }
}

extension View
{
    func cardify(isFaceUp: Bool, dashedBorder: Bool) -> some View
    {
        modifier(Cardify(isFaceUp: isFaceUp, dashedBorder: dashedBorder))
    }
}
