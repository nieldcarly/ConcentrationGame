//
//  CardView.swift
//  concentration
//
//  Created by Carly Nield on 9/10/20.
//

import SwiftUI

struct NavCardView: View {
    var card: ConcentrationGame<String>.NavCard

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Group {
                    RoundedRectangle(cornerRadius: cardCornerRadius).fill(Color.white)
                    RoundedRectangle(cornerRadius: cardCornerRadius).stroke()
                    if (card.gameType == "Temple") {
                        VStack {
                            Spacer()
                            NavigationLink(
                                destination: TempleNavView(highScores: []),
                                label: {
                                    Text(verbatim: card.gameTitle)
                                })
                            Image("durban")
                                .resizable()
                                .scaledToFit()
                                .cornerRadius(10)
                                .padding()
                            Text("High Score: ")
                                .font(.system(size: 14))
                            Spacer()
                        }
                    } else if (card.gameType == "Emoji"){
                        VStack {
                            NavigationLink(
                                destination: EmojiNavView(),
                                label: {
                                    Text(verbatim: card.gameTitle)
                                })
                                .padding()
                            Text("🥝")
                                .font(systemFont(for: geometry.size))
                            Text("High Score: ")
                                .font(.system(size: 14))
                                .padding()
                        }
                    } else if (card.gameType == "World") {
                        VStack {
                            Spacer()
                            NavigationLink(
                                destination: TempleConcentrationGameView(templeGame: TempleConcentrationGame(themeName: "International")),
                                label: {
                                    Text(verbatim: card.gameTitle)
                                })
                            Image("london")
                                .resizable()
                                .scaledToFit()
                                .cornerRadius(10)
                                .padding()
                            Text("High Score: ")
                                .font(.system(size: 14))
                            Spacer()
                        }
                    }
                    else if (card.gameType == "Shape") {
                        VStack {
                            NavigationLink(
                                destination: ShapeConcentrationGameView(shapeGame: ShapeConcentrationGame()),
                                label: {
                                    Text(verbatim: card.gameTitle)
                                })
                                .padding()
                                .position(x: 70.0, y:40.0)
                            Circle()
                                .size(CGSize(width: 85, height: 85))
                                .position(x: 65.0, y: 0.0)
                                .padding()
                                .foregroundColor(.red)
                            Text("High Score: ")
                                .font(.system(size: 14))
                                .padding()
                            Spacer()
                        }
                    }
                }
        }
    }
        .aspectRatio(cardAspectRatio, contentMode: .fit)

    }
    
    private func systemFont(for size: CGSize) -> Font {
        return Font.system(size: min(size.width, size.height) * fontScaleFactor)
    }
    
    private let cardAspectRatio: CGFloat = 2/3
    private let fontScaleFactor: CGFloat = 0.4
    private let cardCornerRadius: CGFloat = 10

}

struct NavCardView_Previews: PreviewProvider {
    static var previews: some View {
        NavCardView(card: ConcentrationGame<String>.NavCard(id: 1, gameTitle: "Shape Scape", gameType: "Temple"))
            .foregroundColor(.blue)
            .padding(50)
        
    }
}
