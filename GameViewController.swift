//
//  GameViewController.swift
//  BlackJack Project
//
//  Created by w0449589 on 2022-04-15.
//

import UIKit

class GameViewController: UIViewController {

    @IBOutlet weak var houseImg1: UIImageView!
    @IBOutlet weak var houseImg2: UIImageView!
    @IBOutlet weak var playerImg1: UIImageView!
    @IBOutlet weak var playerImg2: UIImageView!
    
    @IBOutlet weak var hitButton: UIButton!
    @IBOutlet weak var startButton: UIButton!
    var createdDeck: [String] = []
    var suits: [String] = ["clubs", "diamonds", "hearts", "spades"]
    var houseCards: [String] = []
    var playerCards: [String] = []
    

    override func viewDidLoad() {
        super.viewDidLoad()
        deckSetup()
        // Do any additional setup after loading the view.
    }
    @IBAction func startButtonPressed(_ sender: UIButton) {
        hitButton.isHidden = false;
        startButton.isHidden = true;
        shuffleDeck()
        houseCards.append(createdDeck[0])
        houseCards.append(createdDeck[1])
        playerCards.append(createdDeck[2])
        playerCards.append(createdDeck[3])
        printHouseCards()
        printPlayerCards()
    }
    @IBAction func buttonPressed(_ sender: UIButton) {
    }
    
    func printHouseCards() {
        print("House cards: \(houseCards)")
    }
    
    func printPlayerCards() {
        print("Player cards: \(playerCards)")
    }
    
    func shuffleDeck() {
        createdDeck.shuffle();
        print(createdDeck)
    }
    
    func deckSetup () {
        for cardType in suits {
            for i in 2...14 {
                if i < 11 {
                    let card = String(i) + "_of_" + cardType
                    createdDeck.append(card)
                } else {
                    switch i {
                        case 11:
                            let card = "jack_of_" + cardType
                            createdDeck.append(card)
                            break;
                        case 12:
                            let card = "queen_of_" + cardType
                            createdDeck.append(card)
                            break;
                        case 13:
                            let card = "king_of_" + cardType
                            createdDeck.append(card)
                            break;
                        case 14:
                            let card = "ace_of_" + cardType
                            createdDeck.append(card)
                            break;
                        default:
                            let card = "Card error"
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
