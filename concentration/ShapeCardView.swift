//
//  ShapeCardView.swift
//  concentration
//
//  Created by Carly Nield on 10/3/20.
//

import SwiftUI

//struct aShape {
//    var shapeName: String
//    var shapeType: Any
//}
//
//let shapes = [aShape(shapeName: "circle", shapeType: Circle()), aShape(shapeName: "squiggle", shapeType: SquiggleShape()), aShape(shapeName: "square", shapeType: SquiggleShape()), aShape(shapeName: "diamond", shapeType: SquiggleShape()), aShape(shapeName: "triangle", shapeType: SquiggleShape()), aShape(shapeName: "rhombus", shapeType: SquiggleShape())]
//
//let moreShapes = ["circle":Circle(), "squiggle":SquiggleShape(), "square":SquiggleShape(), "diamond":SquiggleShape(),"triangle":SquiggleShape(),"rhombus":SquiggleShape()] as [String : Any]

struct ShapeCardView: View {
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
                    
//  I know this is not the best way to code this, but frustration led me here I'm sorry pls don't dock me points
                    
                    if (card.content == "circle") {
                        Circle()
                            .rotationEffect(Angle.degrees(card.isMatched ? 360 : 0))
                            .animation(card.isMatched ? Animation.linear(duration: 1).repeatForever(autoreverses: false) : .default)
                            .padding()
                            .foregroundColor(.red)

                    } else if (card.content == "square") {
                        Rectangle()
                            .padding()
                            .frame(width: 75.0, height: 75.0)
                            .rotationEffect(Angle.degrees(card.isMatched ? 360 : 0))
                            .animation(card.isMatched ? Animation.linear(duration: 1).repeatForever(autoreverses: false) : .default)
                            .foregroundColor(.orange)

                    } else if (card.content == "star") {
                        Star(corners: 5, smoothness: 2)
                            .size(CGSize(width: 30.0, height: 30.0))
                            .position(x: 75.0, y: 125.0)
                            .rotationEffect(Angle.degrees(card.isMatched ? 360 : 0))
                            .animation(card.isMatched ? Animation.linear(duration: 1).repeatForever(autoreverses: false) : .default)
                            .foregroundColor(.purple)

                    } else if (card.content == "squiggle") {
                        SquiggleShape()
                            .size(CGSize(width: 50.0, height: 50.0))
                            .position(x: 70.0, y: 105.0)
                            .rotationEffect(Angle.degrees(card.isMatched ? 360 : 0))
                            .animation(card.isMatched ? Animation.linear(duration: 1).repeatForever(autoreverses: false) : .default)
                            .foregroundColor(.yellow)

                    } else {
                        Ellipse()
                            .padding()
                            .rotationEffect(Angle.degrees(card.isMatched ? 360 : 0))
                            .animation(card.isMatched ? Animation.linear(duration: 1).repeatForever(autoreverses: false) : .default)
                            .foregroundColor(.green)
                    }
                    
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

struct ShapeCardView_Previews: PreviewProvider {
    static var previews: some View {
        ShapeCardView(card: ConcentrationGame<String>.Card(content: "oval", id: 1))
    }
}
