//
//  ConcentrationGame.swift
//  concentration
//
//  Created by Carly Nield on 9/9/20.
//

import Foundation
import SwiftUI
import AVFoundation

struct ConcentrationGame<CardContent> where CardContent: Equatable {
    private(set) var cards: Array<Card>
    var score: Int
    var theme: String
    private var indexOfTheOneAndOnlyOneFaceUpCard: Int?
    var player: AVAudioPlayer?
    
    init(gameTheme: String, numberOfPairsOfCards : Int, cardContentFactory : (Int) -> CardContent) {
        cards = Array<Card>()
        score = 0
        theme = gameTheme
         
        for pairIndex in 0..<numberOfPairsOfCards {
            let content = cardContentFactory(pairIndex)

            cards.append(Card(content: content, id: pairIndex * 2))
            cards.append(Card(content: content, id: (pairIndex * 2) + 1))
        }
        
        cards.shuffle()
    }
    
    mutating func choose(_ card: Card) {// mutating = function is in a struct and makes change to property
        var gameFinished = true
        print("You chose \(card)")
        if let chosenIndex = cards.firstIndex(matching: card),
               !cards[chosenIndex].isFaceUp,
               !cards[chosenIndex].isMatched { // we have to do an if let because chosenIndex returns an optional int
            if let potentialMatchIndex = indexOfTheOneAndOnlyOneFaceUpCard {
                if cards[chosenIndex].content == cards[potentialMatchIndex].content {
                    cards[chosenIndex].isMatched = true
                    cards[potentialMatchIndex].isMatched = true
                    score = score + 2
                } else {
                    if (cards[chosenIndex].previouslySeen == true || cards[potentialMatchIndex].previouslySeen == true) {
                        score = score - 1
                    } else {
                        cards[chosenIndex].previouslySeen = true
                        cards[potentialMatchIndex].previouslySeen = true
                    }
                }
                indexOfTheOneAndOnlyOneFaceUpCard = nil
            } else {
                for index in cards.indices { //iterate
                    cards[index].isFaceUp = false
                }
                indexOfTheOneAndOnlyOneFaceUpCard = chosenIndex
            }
            cards[chosenIndex].isFaceUp.toggle()
        }
        
        for index in cards.indices {
            if (cards[index].isMatched == false) {
                gameFinished = false
            }
        }
        if (gameFinished == true) {
            if (score > getHighScore(themeName: theme)) {
                setHighScore(highScore: score)
            }
        }
    }
    
    mutating func dealCard(_ index: Int) {
        cards[index].isDealt = true
    }
    
    func getHighScore(themeName: String) -> Int {
        
        let defaults = UserDefaults.standard

        if var HighScore = defaults.object(forKey: themeName) {
            HighScore = Int(HighScore as! String) ?? String()
            return HighScore as? Int ?? 0
        }
        return -10
    }
    
    func setHighScore(highScore: Int) {
        let myString = String(highScore) // This String is you high score as a String

        let defaults = UserDefaults.standard

        defaults.set(myString, forKey : theme) // Saving the String to NSUserDefaults
    }
    
    func playSound() {
        guard let url = Bundle.main.url(forResource: "soundName", withExtension: "mp3") else { return }

        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playback)
            try AVAudioSession.sharedInstance().setActive(true)

            let player = try AVAudioPlayer(contentsOf: url)

            player.play()

        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    struct NavCard: Identifiable {
        var id: Int
        var gameTitle: String
        var gameType: String
        var gameThemes: Array<String>?
    }
    
    struct Card: Identifiable {
        private let maxScore = 5
        private let maxMatchBonus = 5.0
        var isDealt = false
        var isFaceUp = false {
            didSet {
                if isFaceUp {
                    startUsingBonusTime()
                } else {
                    stopUsingBonusTime()
                }
            }
        }
        var previouslySeen = false
        var isMatched = false {
            didSet {
                stopUsingBonusTime()
            }
        }
        var content: CardContent
        var id: Int
        var score: Int {
            if isMatched {
                return maxScore + Int(bonusRemaining * maxMatchBonus)
            } else {
                return 0
            }
        }
        
        var bonusTimeLimit: TimeInterval = 12
        var lastFaceUpTime: Date?
        var pastFaceUpTime: TimeInterval = 0
        var bonusTimeRemaining: TimeInterval {
            max(0, bonusTimeLimit - faceUpTime)
        }
        var bonusRemaining: Double {
            (bonusTimeLimit > 0 && bonusTimeRemaining > 0) ? bonusTimeRemaining / bonusTimeLimit : 0
        }
        
        var hasEarnedBonus: Bool {
            isMatched && bonusTimeRemaining > 0
        }
        
        var isConsumingBonusTime: Bool {
            isFaceUp && isMatched && bonusTimeRemaining > 0
        }
        
        private var faceUpTime: TimeInterval {
            if let lastFaceUpTime = lastFaceUpTime {
                return pastFaceUpTime + Date().timeIntervalSince(lastFaceUpTime)
            } else {
                return pastFaceUpTime
            }
        }
        
        private mutating func startUsingBonusTime() {
            if isConsumingBonusTime && lastFaceUpTime == nil {
                lastFaceUpTime = Date()
            }
        }
        
        private mutating func stopUsingBonusTime() {
            pastFaceUpTime = faceUpTime
            lastFaceUpTime = nil
        }
    }
}

