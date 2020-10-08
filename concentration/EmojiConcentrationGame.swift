//
//  EmojiConcentrationGame.swift
//  concentration
//
//  Created by Carly Nield on 9/9/20.
//

import SwiftUI

class EmojiConcentrationGame: ObservableObject {
    @Published private var game: ConcentrationGame<String> // this calls objectwillchange.send()

    private var currentTheme: Theme
    
    init(themeName: String) {
        currentTheme = EmojiConcentrationGame.themes[themeName]!
        game = EmojiConcentrationGame.createGame(theme: currentTheme)
    }
    
    struct Theme {
        var emojis : Array<String>
        var color: Color
        var numPairs: Int
        var name: String
    }
    // observableobject is a protocol that gives us objectwillchange
    
    // TO DO: Fix random color
    
    
    private static let themes = ["Bread":Theme(emojis: ["🥖","🍞","🥯","🥨","🥮"], color: .green, numPairs: 4, name: "Bread"), "Faces":Theme(emojis: ["😀","🤓","🤠","🥺","😎","🥳"], color: .blue, numPairs: 4, name: "Faces"), "Fruit":Theme(emojis: ["🍇", "🍏", "🍉", "🍍", "🥥", "🥝"], color: .purple, numPairs: 4, name:"Fruit"),"Vegetables":Theme(emojis: ["🌽", "🌶", "🥦", "🍠", "🥕"], color: .red, numPairs: 4, name: "Vegetables"), "Halloween":Theme(emojis:["🎃", "👹", "👻", "🍁", "🌜"], color: .black, numPairs: 4, name: "Halloween"), "Random":Theme(emojis: ["🥨", "🥑", "👻", "🌶", "🥐", "🥯", "🍒", "🥦"], color: .blue, numPairs: Int.random(in: 2...4), name: "Random")]

    private static func createGame(theme: Theme) -> ConcentrationGame<String>{
        ConcentrationGame<String>(gameTheme: theme.name, numberOfPairsOfCards: theme.numPairs) { index in
            theme.emojis[index]
        }
    }
    
    var score: Int {
        game.score
    }
    
    var cards: Array<ConcentrationGame<String>.Card> {
        game.cards
    }
    
    func dealCard(_ index: Int) {
        game.dealCard(index)
    }
    
    func choose(_ card: ConcentrationGame<String>.Card) {
        game.choose(card)
    }
    
    func newGame(){
        game = EmojiConcentrationGame.createGame(theme: currentTheme)
    }
    
    func getColor() -> Color {
        currentTheme.color
    }
    
    func getEmoji() -> String {
        currentTheme.emojis[0]
    }
}


struct SoundPlayer {
//    try? AVAudioSession.sharedInstance().setCategory(.ambient)
}
