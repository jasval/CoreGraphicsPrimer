/// Copyright (c) 2021 Razeware LLC

import UIKit

class CounterView: UIView {
    
    private struct Constants {
        static let numberOfGlasses = 8
        static let lineWidth: CGFloat = 5.0
        static let arcWidth: CGFloat = 76
        
        static var halfOfLineWidth: CGFloat {
            return lineWidth / 2
        }
    }
    
    var counter: Int = 0 {
        didSet {
            if counter <= Constants.numberOfGlasses {
                setNeedsDisplay()
            }
        }
    }
    var outlineColor: UIColor = UIColor(red: 34/255, green: 110/255, blue: 100/255, alpha: 1.0)
    var counterColor: UIColor = UIColor(red: 87/255, green: 218/255, blue: 213/255, alpha: 1.0)
    

    override func draw(_ rect: CGRect) {
        let center = CGPoint(x: bounds.width / 2, y: bounds.height / 2)
        let radius = max(bounds.width, bounds.height)
        
        let startAngle: CGFloat = 3 * .pi / 4
        let endAngle: CGFloat = .pi / 4
        
        let path = UIBezierPath(arcCenter: center,
                                radius: radius / 2 - Constants.arcWidth / 2,
                                startAngle: startAngle,
                                endAngle: endAngle,
                                clockwise: true)
        
        path.lineWidth = Constants.arcWidth
        counterColor.setStroke()
        path.stroke()
        
        
        /// Draw the outline
        // Ensuring it is positive
        let angleDiff: CGFloat = 2 * .pi - startAngle + endAngle
        // then calculate the arc for each single glass
        let arcLengthPerGlass = angleDiff / CGFloat(Constants.numberOfGlasses)
        // then multiply out by the actual glasses drunk
        let outlineEndAngle = arcLengthPerGlass * CGFloat(counter) + startAngle
        
        ///2 - Draw the outer arc
        let outerArcRadius = bounds.width / 2 - Constants.halfOfLineWidth
        let outlinePath = UIBezierPath(arcCenter: center, radius: outerArcRadius, startAngle: startAngle, endAngle: outlineEndAngle, clockwise: true)
        
        ///3 - Draw the inner arc
        
        let innerArcRadius = bounds.width / 2 - Constants.arcWidth + Constants.halfOfLineWidth
        // Adds an inner arc to the first arc. It has the same angles but draws in reverse. That’s why clockwise was set to false. Also, this draws a line between the inner and outer arc automatically.
        outlinePath.addArc(withCenter: center, radius: innerArcRadius, startAngle: outlineEndAngle, endAngle: startAngle, clockwise: false)
        
        outlinePath.close()
        
        outlineColor.setStroke()
        outlinePath.lineWidth = Constants.lineWidth
        outlinePath.stroke()
        
        // MARK: - Adding the markers
        
        guard let context = UIGraphicsGetCurrentContext() else { return }
        
        context.saveGState()
        outlineColor.setFill()
        
        let markerWidth: CGFloat = 5.0
        let markerSize: CGFloat = 10.0
        
        let markerPath = UIBezierPath(rect: CGRect(x: -markerWidth / 2, y: 0, width: markerWidth, height: markerSize))
        
        context.translateBy(x: rect.width / 2, y: rect.height / 2)
        
        for i in 1...Constants.numberOfGlasses {
            context.saveGState()
            let angle = arcLengthPerGlass * CGFloat(i) + startAngle - .pi / 2
            context.rotate(by: angle)
            context.translateBy(x: 0, y: rect.height / 2 - markerSize)
            
            markerPath.fill()
            context.restoreGState()
        }
        
        context.restoreGState()
    }
    
    override func didAddSubview(_ subview: UIView) {
        subview.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            subview.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            subview.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
    }

}
