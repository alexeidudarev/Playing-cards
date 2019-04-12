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
    @IBOutlet var cardViews: [PlayingCardView]!
    lazy var animator = UIDynamicAnimator(referenceView: view)
    lazy var cardBehavior = CardBehavior(in: animator)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var cards = [PlayingCard]()
        for _ in 1...((cardViews.count + 1 )/2) {
            let card = deck.draw()!
            cards += [card, card]
        }
        for cardView in cardViews{
            cardView.isFaceUp = false
            let card  =  cards.remove(at: cards.count.arc4random)
            cardView.rank = card.rank.order
            cardView.suit = card.suit.rawValue
            cardView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(flipCard(_:))))
            cardBehavior.addItem(cardView)
           
            
        }
        
        
        
        
        /*
        for _ in 1...10{
            let card = deck.draw()
            print("\(card)")
            
        }
         */
    }
    private var faceUpCardViewsMatch : Bool{
        return faceUpCardViews.count == 2 && faceUpCardViews[0].rank == faceUpCardViews[1].rank
        && faceUpCardViews[0].suit == faceUpCardViews[1].suit
        
    }
    private var faceUpCardViews : [PlayingCardView]{
        return cardViews.filter{$0.isFaceUp && !$0.isHidden && $0.transform != CGAffineTransform.identity.scaledBy(x: 3.0, y: 3.0) && $0.alpha == 1}
    }
    var lastChosenCardView : PlayingCardView?
    @objc func flipCard(_ recognizer : UITapGestureRecognizer){
        switch recognizer.state{
        case . ended:
            if let choosenView = recognizer.view as? PlayingCardView , faceUpCardViews.count < 2{
                lastChosenCardView = choosenView
                cardBehavior.removeItem(choosenView)
                
                UIView.transition(
                    with: choosenView,
                    duration: 0.6,
                    options: [.transitionFlipFromLeft],
                    animations: { choosenView.isFaceUp = !choosenView.isFaceUp},
                    completion : { finished in
                        let cardsToAnimate = self.faceUpCardViews
                        if self.faceUpCardViewsMatch {
                            //cards is match , should be removed
                            UIViewPropertyAnimator.runningPropertyAnimator(
                                withDuration: 2.0,
                                delay: 0,
                                options: [],
                                animations: {
                                    //matched card will make bigger
                                   cardsToAnimate.forEach{ $0.transform = CGAffineTransform.identity.scaledBy(x: 3.0, y: 3.0)
                                    }
                            },
                                //make card smaller and make them gone
                                completion: { position  in
                                    
                                    UIViewPropertyAnimator.runningPropertyAnimator(
                                        withDuration: 2.0,
                                        delay: 0,
                                        options: [],
                                        animations: {
                                            //matched card will make smaller and gone form view
                                            cardsToAnimate.forEach{
                                                $0.transform = CGAffineTransform.identity.scaledBy(x: 0.1, y: 0.1)
                                                $0.alpha = 0
                                            }
                                    },
                                        // make some clean up
                                        completion: { position  in
                                            self.faceUpCardViews.forEach{
                                                $0.isHidden = true
                                                $0.alpha = 1
                                                $0.transform = .identity
                                            }
                                        
                                    }
                                    )
                                    
                                    
                                    
                                    
                                    
                                }
                            )
                        }else if self.faceUpCardViews.count == 2{
                            if choosenView == self.lastChosenCardView{
                                //to flip card back
                                self.faceUpCardViews.forEach { cardView in
                                    UIView.transition(
                                        with: cardView,
                                        duration: 0.6,
                                        options: [.transitionFlipFromLeft],
                                        animations: { cardView.isFaceUp = false
                                            
                                        },
                                        completion: { finished in
                                            self.cardBehavior.addItem(cardView)
                                            
                                        }
                                        
                                    )
                                }
                            }
                        }else{
                            if !choosenView.isFaceUp{
                                self.cardBehavior.addItem(choosenView)
                            }
                        }
                    }
            )}
        default : break
        }
    }

}
extension  ViewController{
    /*
    @IBOutlet weak var playingCardView: PlayingCardView!{
        didSet{
            let swipe  = UISwipeGestureRecognizer(target: self, action: #selector(nextCard))
            swipe.direction = [.left, .right]
            playingCardView.addGestureRecognizer(swipe)
            let  pinch  = UIPinchGestureRecognizer(target: playingCardView, action: #selector (PlayingCardView.adjustFaceCardScale(byHandlingGestureRecognizerBy: )))
            playingCardView.addGestureRecognizer(pinch)
            
        }
        
    }
    @objc func nextCard(){
        if let card = deck.draw(){
            playingCardView.rank = card.rank.order
            playingCardView.suit = card.suit.rawValue
        }
    }
    @IBAction func flipCard(_ sender: UITapGestureRecognizer) {
        switch sender.state{
        case .ended :
            playingCardView.isFaceUp = !playingCardView.isFaceUp
        default : break
        }
        
        
    }
 */
    
}
extension CGFloat {
    var arc4random: CGFloat {
        return self * (CGFloat(arc4random_uniform(UInt32.max))/CGFloat(UInt32.max))
    }
}
