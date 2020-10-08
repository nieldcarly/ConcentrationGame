//
//  ThemeNavView.swift
//  concentration
//
//  Created by Carly Nield on 9/27/20.
//

import SwiftUI

struct EmojiNavView: View {
    
    private let emojiThemes = ["Bread","Faces","Fruit","Vegetables","Halloween","Random"]
//        private let emojiThemes = ["Bread":"🥖","Faces":"😀","Fruit":"🍎","Vegetables":"🥦","Halloween":"👻","Random":"🍫"]

    
    private let desiredCardWidth: CGFloat = 100
    
    private func columns(for size: CGSize) -> [GridItem] {
        Array(repeating: GridItem(.flexible()), count: Int(size.width / desiredCardWidth))
    }
    private let cardAspectRatio: CGFloat = 2/3
    private let cardCornerRadius: CGFloat = 16

    
    var body: some View {
        NavigationView {
                GeometryReader { geometry in
                    LazyVGrid(columns: columns(for: geometry.size)) {
                        ForEach(emojiThemes,  id: \.self) { theme in
                            ZStack {
                                Group {
                                    RoundedRectangle(cornerRadius: cardCornerRadius).fill(Color.white)
                                    RoundedRectangle(cornerRadius: cardCornerRadius).stroke()
                                    VStack {
                                        NavigationLink(
                                            destination:
                                                EmojiConcentrationGameView(emojiGame: EmojiConcentrationGame(themeName: theme)),
                                            label: {
                                                Text(theme)
                                            })
                                            .padding()
                                        Text(EmojiConcentrationGame(themeName: theme).getEmoji())
                                        Text("High Score: ")
                                            .font(.system(size: 14))
                                            .padding()
                                    }
                                }
                            }
                        }
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


struct EmojiNav_Previews: PreviewProvider {
    static var previews: some View {
        EmojiNavView()
    }
}
