//
//  ViewController.swift
//  PlayingCard
//
//  Created by oleksiy dudarev on 3/29/19.
//  Copyright © 2019 oleksiy dudarev. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var deck = PlayingCardDeck()
    override func viewDidLoad() {
        super.viewDidLoad()
        for _ in 1...10{
            let card = deck.draw()
            print("\(card)")
            
        }
    }


}

