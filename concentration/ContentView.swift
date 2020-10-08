//
//  ContentView.swift
//  concentration
//
//  Created by Carly Nield on 9/9/20.
//

import SwiftUI

struct ConcentrationGameView: View {
    @ObservedObject var emojiGame: EmojiConcentrationGame // connects to viewmodel to make things reactive
    
    var fontForGameSize: Font {
        emojiGame.cards.count < 10 ? .largeTitle : .body
    }
    
    var body: some View {
        HStack {
            ForEach(emojiGame.cards) { card in
                CardView(card: card, emojiFont: fontForGameSize).onTapGesture(
                    emojiGame.choose(card: card)
                )
            }
        }
        .padding()
        .foregroundColor(.blue)
    }
}

/*struct CardView: View {
    var card: ConcentrationGame<String>.Card
    
    var body: some View {
        ZStack {
            if card.isFaceUp {
            RoundedRectangle(cornerRadius: 10).fill(Color.white)
            RoundedRectangle(cornerRadius: 10).stroke()
                Text(card.content)
                .font(.largeTitle)
            } else {
                RoundedRectangle(cornerRadius: 10).fill()
            }
        }
        .aspectRatio(2/3, contentMode: .fit)
    }
}*/

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ConcentrationGameView(emojiGame: EmojiConcentrationGame())
    }
}
