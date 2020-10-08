//
//  Cardify.swift
//  concentration
//
//  Created by Carly Nield on 9/21/20.
//

import SwiftUI

struct Cardify: AnimatableModifier {
    var rotation: Double
    
    var isFaceUp: Bool {
        rotation < 90
    }
    
    var animatableData: Double {
        get {
            rotation
        }
        set {
            rotation = newValue
        }
    }
    
    init(isFaceUp: Bool) {
        rotation = isFaceUp ? 0 : 180
    }
    
    func body(content: Content) -> some View {
        ZStack {
            Group {
            RoundedRectangle(cornerRadius: cardCornerRadius).fill(Color.white)
            RoundedRectangle(cornerRadius: cardCornerRadius).stroke()
                content
            }
            .opacity(isFaceUp ? 1 : 0)
            
            RoundedRectangle(cornerRadius: cardCornerRadius)
                .opacity(isFaceUp ? 0 : 1)
            }
        .rotation3DEffect(Angle.degrees(rotation),
            axis: (0, 1, 0))
    }
    private let cardCornerRadius: CGFloat = 10
}

struct Cardify_Previews: PreviewProvider {
    static var previews: some View {
        Text("🥨").modifier(Cardify(isFaceUp: true))
            .padding()
    }
}

extension View {
    func cardify(isFaceUp: Bool) -> some View {
        modifier(Cardify(isFaceUp: isFaceUp))
    }
}
