//
//  PlayingCardView.swift
//  PlayingCard
//
//  Created by oleksiy dudarev on 3/29/19.
//  Copyright © 2019 oleksiy dudarev. All rights reserved.
//

import UIKit

class PlayingCardView: UIView {
    var rank : Int = 5 { didSet { setNeedsDisplay();setNeedsLayout()}}
    var suit : String = "♥️" { didSet { setNeedsDisplay();setNeedsLayout()}}
    var isFaceUp : Bool = true { didSet { setNeedsDisplay();setNeedsLayout()}}
    
    private func centeredAttributedString(_ string: String, fontSize : CGFloat)->NSAttributedString{
        var font = UIFont.preferredFont(forTextStyle: .body).withSize(fontSize)
        font = UIFontMetrics(forTextStyle: .body).scaledFont(for: font)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        return NSAttributedString(string: string, attributes: [.paragraphStyle: paragraphStyle,.font:font])
     
    }
  
    private var cornerString: NSAttributedString{
        return centeredAttributedString(rankString+"\n"+suit, fontSize: cornerFontSize)
    }
    private lazy var upperLeftCornerLabel = createCornerLabel()
    private lazy var lowerRightCornerLabe  = createCornerLabel()
    
    private func createCornerLabel()-> UILabel {
        let label  = UILabel()
        label.numberOfLines = 0
        addSubview(label)
        return label
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        upperLeftCornerLabel.frame.origin = bounds.origin
    }
    override func draw(_ rect: CGRect) {
        let roundedRect = UIBezierPath(roundedRect: bounds, cornerRadius:  cornerRadius)
        roundedRect.addClip()
        UIColor.white.setFill()
        roundedRect.fill()
        
        
        /*
        //drawing some circle using context
         
         
        if let context = UIGraphicsGetCurrentContext(){
            context.addArc(center: CGPoint(x: bounds.midX, y: bounds.midY), radius: 100.0, startAngle: 0, endAngle: 2*CGFloat.pi, clockwise: true)
            context.setLineWidth (5.0)
            UIColor.green.setFill()
            UIColor.red.setStroke()
            context.strokePath()
            context.fillPath()
            
        }
        
        //drawing some circle using path
         
        let path = UIBezierPath()
        path.addArc(withCenter: CGPoint(x: bounds.midX, y: bounds.midY), radius: 100.0, startAngle: 0, endAngle: 2*CGFloat.pi, clockwise: true)
        path.lineWidth = 5.0
        UIColor.green.setFill()
        UIColor.red.setStroke()
        path.stroke()
        path.fill()
        */
        
    }
    

}
extension PlayingCardView{
    private struct SizeRatio{
        static let cornerFontSizeToBoundsHeight: CGFloat = 0.085
        static let cornerRadiusToBoundsHeight: CGFloat = 0.06
        static let cornerOffSetToCorenerRadius : CGFloat = 0.33
        static let faceCardImageSizeToBoundsSize :CGFloat = 0.75
    }
    private var cornerRadius : CGFloat{
        return bounds.size.height * SizeRatio.cornerRadiusToBoundsHeight
    }
    private var cornerOffset: CGFloat{
        return cornerRadius * SizeRatio.cornerOffSetToCorenerRadius
    }
    private var cornerFontSize: CGFloat{
        return bounds.size.height * SizeRatio.cornerFontSizeToBoundsHeight
    }
    private var rankString: String{
        switch rank{
        case 1 : return "A"
        case 2...10: return String(rank)
        case 11 : return "J"
        case 12 : return "Q"
        case 13: return "K"
        default : return "?"
        }
    }
}
extension CGRect{
    
}
extension CGPoint{
    func offsetBy(dx:CGFloat,dy:CGFloat)->CGPoint{
        return CGPoint(x: x+dx, y: y+dy)
    }
}
