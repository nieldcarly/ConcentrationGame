//
//  CardView.swift
//  concentration
//
//  Created by Carly Nield on 9/10/20.
//

import SwiftUI

struct TempleCardView: View {
    var card: ConcentrationGame<Image>.Card
    
    @State private var animatedBonusRemaining = 0.0
    
    var body: some View {
        GeometryReader { geometry in
            if card.isFaceUp || !card.isMatched {
                ZStack {
                    
                    card.content
                        .resizable()
                        .scaledToFit()
                        .cornerRadius(10)
                        .scaleEffect(CGSize(width: (card.isMatched ? 1.5 : 1), height: (card.isMatched ? 1.5 : 1)))
                        .animation(card.isMatched ? Animation.linear(duration: 1).repeatForever() : .default)
                    Group {
                        if card.isConsumingBonusTime {
                            Rectang(percentage: CGFloat(animatedBonusRemaining))
                            .onAppear() {
                                startBonusTimeAnimation()
                            }
                        } else {
                            Rectang(percentage: CGFloat(animatedBonusRemaining))
                        }
                    }
                    .padding()
                    .transition(.identity)
                }
                .cardify(isFaceUp: card.isFaceUp)
                .transition(.scale)
            }
        }
        .aspectRatio(cardAspectRatio, contentMode: .fit)
    }
    
    private func angle(for degrees: Double) -> Angle {
        Angle.degrees(degrees * 360 - 90)
    }
    
    private func startBonusTimeAnimation() {
        animatedBonusRemaining = card.bonusRemaining
        withAnimation(.linear(duration: card.bonusRemaining)) {
            animatedBonusRemaining = 0
        }
    }
    
    private func systemFont(for size: CGSize) -> Font {
        return Font.system(size: min(size.width, size.height) * fontScaleFactor)
    }
    
    private let cardAspectRatio: CGFloat = 5/3
    private let fontScaleFactor: CGFloat = 0.20
}

struct ImageCardView_Previews: PreviewProvider {
    static var previews: some View {
        TempleCardView(card: ConcentrationGame<Image>.Card(content: Image("london"), id: 1))
            .foregroundColor(.purple)
            .padding(50)
        
    }
}
