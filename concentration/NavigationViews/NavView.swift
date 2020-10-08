//
//  NavView.swift
//  concentration
//
//  Created by Carly Nield on 9/27/20.
//

import SwiftUI

struct NavView: View {
    private let desiredCardWidth: CGFloat = 100
    
    private func columns(for size: CGSize) -> [GridItem] {
        Array(repeating: GridItem(.flexible()), count: Int(size.width / desiredCardWidth))
    }
    private let cardAspectRatio: CGFloat = 2/3
    
    var body: some View {
        NavigationView {
                GeometryReader { geometry in
                    LazyVGrid(columns: columns(for: geometry.size)) {

                    NavCardView(card: ConcentrationGame<String>.NavCard.init(id: 1, gameTitle: "Temple Match", gameType: "Temple"))
                        .border(Color.blue)
                    NavCardView(card: ConcentrationGame<String>.NavCard.init(id: 2, gameTitle: "Emoji Mojo", gameType: "Emoji"))
                        .border(Color.blue)
                    NavCardView(card: ConcentrationGame<String>.NavCard.init(id: 3, gameTitle: "Shape Scape", gameType: "Shape"))
                        .border(Color.blue)
                    NavCardView(card: ConcentrationGame<String>.NavCard.init(id: 4, gameTitle: "World Wonders", gameType: "World"))
                        .border(Color.blue)
                    }
                }
                .padding()
                .foregroundColor(.blue)
                .aspectRatio(cardAspectRatio, contentMode: .fit)
                .navigationBarTitle("")
                .navigationBarHidden(true)
            }
        }
    }


struct NavView_Previews: PreviewProvider {
    static var previews: some View {
        NavView()
    }
}
