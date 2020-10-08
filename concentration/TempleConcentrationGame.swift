//
//  ShapeConcentrationGame.swift
//  concentration
//
//  Created by Carly Nield on 9/9/20.
//

import SwiftUI

class TempleConcentrationGame: ObservableObject {
    // observableobject is a protocol that gives us objectwillchange
    @Published private var game: ConcentrationGame<Image> // this calls objectwillchange.send()

    private var currentTheme: Theme
    
    init(themeName: String) {
        currentTheme = TempleConcentrationGame.themes[themeName]!
        game = TempleConcentrationGame.createGame(theme: currentTheme)
    }
    struct Theme {
        var temples : Array<Image>
        var color: Color
        var numPairs: Int
        var name: String
    }
    
    private static var themes = ["International": Theme(temples:[Image("durban"), Image("london"), Image("copenhagen"), Image("saopaulo"), Image("rome"), Image("manila"), Image("suva"), Image("paris"), Image("arequipa"), Image("lisbon"), Image("freiberg"), Image("madrid"), Image("santodomingo")], color: .purple, numPairs: 4, name: "International"), "American": Theme(temples: [Image("sandiego"), Image("birmingham"), Image("starvalley"), Image("nyc"), Image("philly"), Image("dc"), Image("oakland"), Image("laie")], color: .blue, numPairs: 4, name: "American"), "Utah": Theme(temples: [Image("provo"), Image("ogden"), Image("slc"), Image("oquirrh"), Image("draper"), Image("stgeorge"), Image("logan"), Image("payson")], color: .red, numPairs: 4, name: "Utah")]
    
    private static func createGame(theme: Theme) -> ConcentrationGame<Image>{
        //Int.random(in: 2...5)
        ConcentrationGame<Image>(gameTheme: theme.name, numberOfPairsOfCards: theme.numPairs) { index in
            theme.temples[index]
        }
    }
    
    var score: Int {
        game.score
    }
    
    var cards: Array<ConcentrationGame<Image>.Card> {
        game.cards
    }
    
    func choose(_ card: ConcentrationGame<Image>.Card) {
        game.choose(card)
    }
    
    func newGame(){
        game = TempleConcentrationGame.createGame(theme: currentTheme)
    }
    
    func getTemple() -> Image {
        currentTheme.temples[0]
    }
}
