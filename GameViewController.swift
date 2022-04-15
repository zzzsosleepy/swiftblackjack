//
//  GameViewController.swift
//  BlackJack Project
//
//  Created by w0449589 on 2022-04-15.
//

import UIKit

class Card {
    var name = ""
    var value = 0
}

class GameViewController: UIViewController {

    //Card images
    @IBOutlet weak var houseImg1: UIImageView!
    @IBOutlet weak var houseImg2: UIImageView!
    @IBOutlet weak var houseImg3: UIImageView!
    @IBOutlet weak var playerImg1: UIImageView!
    @IBOutlet weak var playerImg2: UIImageView!
    @IBOutlet weak var playerImg3: UIImageView!
    
    //Score labels
    @IBOutlet weak var houseTotalLabel: UILabel!
    @IBOutlet weak var playerTotalLabel: UILabel!
    
    //Buttons
    @IBOutlet weak var hitButton: UIButton!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var stayButton: UIButton!
    
    //Deck & Cards
    var createdDeck: [Card] = []
    var suits: [String] = ["clubs", "diamonds", "hearts", "spades"]
    var houseCards: [Card] = []
    var playerCards: [Card] = []
    var cardIndex = 0;
    
    //Scores
    var playerTotal = 0;
    var houseTotal = 0;
    var playerBust = false;
    var houseBust =  false;
    var playerScore = 0;
    

    override func viewDidLoad() {
        super.viewDidLoad()
        deckSetup()
        // Do any additional setup after loading the view.
    }
    
    //Player hits
    @IBAction func hitButtonPressed(_ sender: UIButton) {
        hitAction()
    }
    
    //Player stays
    @IBAction func stayButtonPressed(_ sender: UIButton) {
       stayAction()
    }
    
    //When the game is started
    @IBAction func startButtonPressed(_ sender: UIButton) {
        hitButton.isHidden = false;
        startButton.isHidden = true;
        stayButton.isHidden = false;
        shuffleDeck()
        houseCards.append(createdDeck[cardIndex])
        cardIndex += 1;
        houseCards.append(createdDeck[cardIndex])
        cardIndex += 1;
        playerCards.append(createdDeck[cardIndex])
        cardIndex += 1;
        playerCards.append(createdDeck[cardIndex])
        cardIndex += 1;
        showPlayerCards()
        showHouseCards()
        updatePlayerTotal()
        updateHouseTotal()
    }
    
    //Draws a card for the player, updating the image and checking the score
    func hitAction() {
        playerImg3.image = UIImage(named: "\(createdDeck[cardIndex].name)");
        if playerImg3.isHidden {
            playerImg3.isHidden = false;
        }
        playerTotal += createdDeck[cardIndex].value
        updatePlayerTotal()
        checkPlayerScore()
        cardIndex += 1;
        if playerBust {
            playerScore -= 50;
            showWinner()
        }
    }
    
    //Draws cards for the house, update the image and checking the score
    func stayAction() {
        houseImg3.image = UIImage(named: "\(createdDeck[cardIndex].name)");
        if houseImg3.isHidden {
            houseImg3.isHidden = false;
        }
        houseTotal += createdDeck[cardIndex].value
        updateHouseTotal()
        checkHouseScore()
        cardIndex += 1;
        if houseTotal < playerTotal {
            stayAction()
        }
        
        if houseTotal >= playerTotal && !houseBust {
            playerScore -= 50;
            showWinner()
        }
        
        if houseBust {
            playerScore += 50;
            showWinner()
        }
    }
    
    //Update the image on the player's cards to reflect their hand
    func showPlayerCards() {
        playerImg1.image = UIImage(named: "\(playerCards[0].name)");
        playerImg2.image = UIImage(named: "\(playerCards[1].name)");
        playerTotal += playerCards[0].value;
        playerTotal += playerCards[1].value;
    }
    
    //Update the image on the house's cards to reflect their hand
    func showHouseCards() {
        houseImg1.image = UIImage(named: "\(houseCards[0].name)");
        houseImg2.image = UIImage(named: "\(houseCards[1].name)");
        houseTotal += houseCards[0].value;
        houseTotal += houseCards[1].value;
    }
    
    //Update the player's current score
    func updatePlayerTotal() {
        playerTotalLabel.text = "Player Total: \(playerTotal)"
    }
    
    //Update the house's current score
    func updateHouseTotal() {
        houseTotalLabel.text = "House Total: \(houseTotal)"
    }
    
    //Show alert for winner
    func showWinner() {
        let msg = self.houseBust ? "Player wins!" : "House wins!";
        let controller = UIAlertController(title: "Game Over", message: msg, preferredStyle: .alert);
        let dismissAction = UIAlertAction(title: "Dismiss", style: .cancel, handler: nil)
        
        controller.addAction(dismissAction);
        present(controller, animated: true, completion: nil);
    }
    
    //Check player's score for bust
    func checkPlayerScore() {
        if playerTotal >= 21 {
            playerBust = true;
        }
    }
    
    //Check house's score for bust
    func checkHouseScore() {
        if houseTotal >= 21 {
            houseBust = true;
        }
    }
    
    //Shuffle the array of cards
    func shuffleDeck() {
        createdDeck.shuffle();
    }
    
    //Create the deck and cards
    func deckSetup () {
        for cardType in suits {
            for i in 2...14 {
                if i < 11 {
                    let card = Card()
                    card.name = String(i) + "_of_" + cardType
                    card.value = i
                    createdDeck.append(card)
                } else {
                    switch i {
                        case 11:
                            let card = Card()
                            card.name = "jack_of_" + cardType
                            card.value = 11
                            createdDeck.append(card)
                            break;
                        case 12:
                            let card = Card()
                            card.name = "queen_of_" + cardType
                            card.value = 12
                            createdDeck.append(card)
                            break;
                        case 13:
                            let card = Card()
                            card.name = "king_of_" + cardType
                            card.value = 13
                            createdDeck.append(card)
                            break;
                        case 14:
                            let card = Card()
                            card.name = "ace_of_" + cardType
                            card.value = 1
                            createdDeck.append(card)
                            break;
                        default:
                            let card = Card()
                            card.name = "Card error"
                            print(card)
                            break;
                        }
                }
            }
        }
    }
    
//    func clubsSetup() {
//        for i in 1...13 {
//            if i < 10 {
//                let card = String(i) + "_of_clubs"
//                createdDeck.append(card)
//            } else {
//                switch i {
//                case 10:
//                    let card = "jack_of_clubs"
//                    createdDeck.append(card)
//                    break;
//                case 11:
//                    let card = "queen_of_clubs"
//                    createdDeck.append(card)
//                    break;
//                case 12:
//                    let card = "king_of_clubs"
//                    createdDeck.append(card)
//                    break;
//                case 13:
//                    let card = "ace_of_clubs"
//                    createdDeck.append(card)
//                    break;
//                default:
//                    let card = "Card error"
//                    print(card)
//                    break;
//                }
//
//            }
//        }
//    }
}
