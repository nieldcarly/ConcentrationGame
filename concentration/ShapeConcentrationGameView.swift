//
//  ContentView.swift
//  concentration
//
//  Created by Carly Nield on 9/9/20.
//

import SwiftUI

struct ShapeConcentrationGameView: View {
    @Environment(\.presentationMode) var presentationMode

    @ObservedObject var shapeGame: ShapeConcentrationGame // connects to viewmodel to make things reactive
    
    private func columns(for size: CGSize) -> [GridItem] {
        Array(repeating: GridItem(.flexible()), count: Int(size.width / desiredCardWidth))
    }
    var body: some View {
        ScrollView {
                VStack{
                    HStack {
                        Button(action: {
                            withAnimation(.easeInOut) {
                                shapeGame.newGame()
                            }
                        }, label: {
                            Text("New Game")
                                .padding(6)
                                .border(Color.orange)
                                .foregroundColor(.orange)
                        })
                        .padding()
                        Text("Score: \(shapeGame.score)")
                        .foregroundColor(.orange)
                        Spacer()
                        Button(action: {self.presentationMode.wrappedValue.dismiss() }, label: {
                            Text("Home")
                                .padding(6)
                                .border(Color.orange)
                                .foregroundColor(.orange)
                        })
                        .padding()
                    }
                    GeometryReader { geometry in

                    LazyVGrid(columns: columns(for: geometry.size)) {
                        ForEach(shapeGame.cards) { card in
                            ShapeCardView(card: card).onTapGesture{
                                withAnimation(.linear(duration: 0.5)) {
                                    self.shapeGame.choose(card)
                                }
                            }
                        }
                    }
                    .padding()
                    .foregroundColor(.red)
                }
            }
        }
        .navigationBarTitle("")
        .navigationBarHidden(true)

    }
    private let desiredCardWidth: CGFloat = 100

}

struct ShapeConcentrationGameView_Previews: PreviewProvider {
    static var previews: some View {
        ShapeConcentrationGameView(shapeGame: ShapeConcentrationGame())
    }
}
