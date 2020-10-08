//
//  CardView.swift
//  concentration
//
//  Created by Carly Nield on 9/10/20.
//

import SwiftUI

struct EmojiCardView: View {
    var card: ConcentrationGame<String>.Card
    
    @State private var animatedBonusRemaining = 0.0
    
    var body: some View {
        GeometryReader { geometry in
            if card.isFaceUp || !card.isMatched {
                ZStack {
                    Group {
                        if card.isConsumingBonusTime {
                            Pie(startAngle: angle(for: 0), endAngle: angle(for: -animatedBonusRemaining))
                            .onAppear() {
                                startBonusTimeAnimation()
                            }
                        } else {
                            Pie(startAngle: Angle.degrees(0-90), endAngle: angle(for: -card.bonusRemaining))
                        }
                    }
                    .padding()
                    .opacity(0.4)
                    .transition(.identity)
                    
                    Text(card.content)
                        .font(systemFont(for: geometry.size))
                        .rotationEffect(Angle.degrees(card.isMatched ? 360 : 0))
                        .animation(card.isMatched ? Animation.linear(duration: 1).repeatForever(autoreverses: false) : .default)
                }
                .foregroundColor(.blue)
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
    
    private let cardAspectRatio: CGFloat = 2/3
    private let fontScaleFactor: CGFloat = 0.70
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        EmojiCardView(card: ConcentrationGame<String>.Card(content: "🥝", id: 1))
            .foregroundColor(.blue)
            .padding(50)
        
    }
}
