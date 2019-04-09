//
//  ViewController.swift
//  Apple Pie
//
//  Created by Sim Yong Seng on 25/2/19.
//  Copyright © 2019 Sim Yong Seng. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var treeImageView:
    UIImageView!
    @IBOutlet weak var correctWordLabel:
    UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    
    @IBOutlet var letterButtons: [UIButton]!
    @IBAction func buttonTap(_ sender: UIButton) {
        sender.isEnabled = false
        let letterString = sender.title(for: .normal)!
        let letter = Character(letterString.lowercased())
        currentGame.playerGuessed(letter: letter)
        print(currentGame.incorrectMovesRemaining)
        print(currentGame.formattedWord)
    }
    
    var listOfWords =
        ["buccanner","basketball","soccer"]
    var incorrectMovesAllowed = 7
    var totalWins = 0 {
        didSet {
            newRound()
        }
    }
    var totalLosses = 0 {
        didSet {
            newRound()
        }
    }
    var currentGame: Game!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newRound()
    }
   
    func newRound() {
        if !listOfWords.isEmpty {
            let newWord = listOfWords.removeFirst()
            currentGame = Game(word: newWord, incorrectMovesRemaining:
                incorrectMovesAllowed, guessedLetters : [])
            enableLetterButtons(true)
            updateUI()
        } else {
            enableLetterButtons (false)
        }
    }
    
    func updateUI() {
        var letters = [String]()
        for letter in currentGame.formattedWord {
            letters.append(String(letter))
            print(letter)
            print("Current formatted word:\(currentGame.formattedWord)")
        }
        let wordWithSpacing = letters.joined(separator: " ")
        correctWordLabel.text = wordWithSpacing
        
        scoreLabel.text = "Wins: \(totalWins), Losses:\(totalLosses)"
        treeImageView.image = UIImage(named: "Tree\(currentGame.incorrectMovesRemaining)")
        
    }
    
    func updatedGameState() {
        if currentGame.incorrectMovesRemaining == 0 {
            totalLosses += 1
        } else if currentGame.word == currentGame.formattedWord {
            totalWins += 1
        }else {
            updateUI()
        }
    }


    func enableLetterButtons(_ enable: Bool) {
        for button in letterButtons {
            button.isEnabled = enable
        }
    }
        

}
