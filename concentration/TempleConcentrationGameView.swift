//
//  ContentView.swift
//  concentration
//
//  Created by Carly Nield on 9/9/20.
//

import SwiftUI

struct TempleConcentrationGameView: View {
    @ObservedObject var templeGame: TempleConcentrationGame // connects to viewmodel to make things reactive
    @Environment(\.presentationMode) var presentationMode

    private func columns(for size: CGSize) -> [GridItem] {
        Array(repeating: GridItem(.flexible()), count: Int(size.width / desiredCardWidth))
    }
    var body: some View {
        ScrollView {
                VStack{
                    HStack {
                        Button(action: {
                            withAnimation(.easeInOut) {
                                templeGame.newGame()
                            }
                        }, label: {
                            Text("New Game")
                                .padding(6)
                                .border(Color.blue)
                                .foregroundColor(.blue)
                        })
                        .padding()
                        Text("Score: \(templeGame.score)")
                        .foregroundColor(.blue)
                        Spacer()
                        Button(action: {self.presentationMode.wrappedValue.dismiss() }, label: {
                            Text("Home")
                                .padding(6)
                                .border(Color.blue)
                                .foregroundColor(.blue)
                        })
                        .padding()
                    }
                    GeometryReader { geometry in

                    LazyVGrid(columns: columns(for: geometry.size)) {
                        ForEach(templeGame.cards) { card in
                            TempleCardView(card: card).onTapGesture{
                                withAnimation(.linear(duration: 0.5)) {
                                    self.templeGame.choose(card)
                                }
                            }
                        }
                    }
                    .padding()
                    .foregroundColor(.purple)
                }
            }
        }
        .navigationBarTitle("")
        .navigationBarHidden(true)

    }
    private let desiredCardWidth: CGFloat = 125

}

struct TempleConcentrationGameView_Previews: PreviewProvider {
    static var previews: some View {
        TempleConcentrationGameView(templeGame: TempleConcentrationGame(themeName: "International"))
    }
}
