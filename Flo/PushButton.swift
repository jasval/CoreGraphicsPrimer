/// Copyright (c) 2021 Razeware LLC

import UIKit

class PushButton: UIButton {
    
    /// When drawing into context you are drawing following a painter's model, so it layers drawings on top of each other ORDER MATTERS!
    private struct Constants {
        static let plusLineWidth: CGFloat = 3.0
        static let plusButtonScale: CGFloat = 0.6
        static let halfPointShift: CGFloat = 0.5
    }
    
    private var halfWidth: CGFloat {
        return bounds.width / 2
    }
    
    private var halfHeight: CGFloat {
        return bounds.height / 2
    }
    
    // When drawing on a view you are drawing in its drawing Core Graphics Context
    override func draw(_ rect: CGRect) {
        let path = UIBezierPath(ovalIn: rect)
        UIColor.green.setFill()
        path.fill()
        
        
        let plusWidth = min(bounds.width, bounds.height) * Constants.plusButtonScale
        
        let halfPlusWidth = plusWidth / 2
        
        let plusPath = UIBezierPath()
        
        plusPath.lineWidth = Constants.plusLineWidth
        
        plusPath.move(to: CGPoint(
                        x: halfWidth - halfPlusWidth + Constants.halfPointShift,
                        y: halfHeight + Constants.halfPointShift))
        
        plusPath.addLine(to: CGPoint(
                            x: halfWidth + halfPlusWidth + Constants.halfPointShift,
                            y: halfHeight + Constants.halfPointShift))
        
        plusPath.move(to: CGPoint(
                        x: halfWidth + Constants.halfPointShift,
                        y: halfHeight - halfPlusWidth + Constants.halfPointShift))
              
        plusPath.addLine(to: CGPoint(
                            x: halfWidth + Constants.halfPointShift,
                            y: halfHeight + halfPlusWidth + Constants.halfPointShift))
        
        UIColor.white.setStroke()
        
        plusPath.stroke()
    }

}
