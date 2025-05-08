import SwiftUI

struct StripView<T>: View where T: Shape {
    let numberOfStrips: Int = 5
    let lineWidth: CGFloat = 2
    let borderLineWidth: CGFloat = 1
    let color = Color.green
    let shape: T
    
    var body: some View {
        HStack(spacing: 0) {
            ForEach(0..<numberOfStrips) { number in
                Color.white
                color.frame(width: lineWidth)
                if number == numberOfStrips - 1 {
                    Color.white
                }
            }
            
        }.mask(shape)
        .overlay(shape.stroke(color, lineWidth: borderLineWidth))
        .frame(width: 100, height: 50)
    }
}

struct WaveShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.addEllipse(in: rect)
        return path
    }
}

struct StripView_Previews: PreviewProvider {
    static var previews: some View {
        StripView(shape: WaveShape())
    }
}