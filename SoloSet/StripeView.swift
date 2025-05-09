//
//  StripView.swift
//  SoloSet
//
//  Created by Wombat on 5/8/25.
//


import SwiftUI

struct StripeView<T>: View where T: Shape {
    let numberOfStrips: Int = 15
    let lineWidth: CGFloat = 2
    let borderLineWidth: CGFloat = 1
    var color : Color
    let shape: T
    
    var body: some View {
        HStack(spacing: 0) {
            ForEach(Array(0..<numberOfStrips), id: \.self)
            {
                number in
                Color.white
                color.frame(width: lineWidth)
                if number == numberOfStrips - 1 {
                    Color.white
                }
            }
            
        }.mask(shape)
        .overlay(shape.stroke(color, lineWidth: borderLineWidth))
        
    }
}

struct WaveShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.addEllipse(in: rect)
        return path
    }
}

struct StripeView_Previews: PreviewProvider {
    static var previews: some View {
        StripeView(color: .green, shape: WaveShape())
    }
}
