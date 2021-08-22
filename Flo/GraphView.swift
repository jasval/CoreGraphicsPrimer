/// Copyright (c) 2021 Razeware LLC

import UIKit

class GraphView: UIView {
    
    var startColor: UIColor = UIColor(red: 250/255, green: 233/255, blue: 222/255, alpha: 1.0)
    var endColor: UIColor = UIColor(red: 252/255, green: 79/255, blue: 8/255, alpha: 1.0)

    override func draw(_ rect: CGRect) {
        guard let context = UIGraphicsGetCurrentContext() else { return }
        let colors = [startColor.cgColor, endColor.cgColor]
        
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        
        let colorLocations: [CGFloat] = [0.0, 1.0]
        
        guard let gradient = CGGradient(colorsSpace: colorSpace, colors: colors as CFArray, locations: colorLocations) else { return }
        
        let startPoint = CGPoint.zero
        let endPoint = CGPoint(x: 0, y: bounds.height)
        context.drawLinearGradient(gradient, start: startPoint, end: endPoint, options: [])
    }

}
