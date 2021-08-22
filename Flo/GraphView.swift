/// Copyright (c) 2021 Razeware LLC

import UIKit

class GraphView: UIView {
    
    private enum Constants {
        static let cornerRadiusSize = CGSize(width: 8.0, height: 8.0)
        static let margin: CGFloat = 20.0
        static let topBorder: CGFloat = 60
        static let bottomBorder: CGFloat = 50
        static let colorAlpha: CGFloat = 0.3
        static let circleDiameter: CGFloat = 5.0
    }
    
    var startColor: UIColor = UIColor(red: 250/255, green: 233/255, blue: 222/255, alpha: 1.0)
    var endColor: UIColor = UIColor(red: 252/255, green: 79/255, blue: 8/255, alpha: 1.0)
    
    
    var graphPoints = [4, 2, 6, 4, 5, 8, 3]

    override func draw(_ rect: CGRect) {
        
        let width = rect.width
        let height = rect.height
        
        // Note: Drawing static views with Core Graphics is generally quick enough, but if your views move around or need frequent redrawing, you should use Core Animation layers. Core Animation is optimized so that the GPU, not the CPU, handles most of the processing. In contrast, the CPU processes view drawing performed by Core Graphics in draw(_:). If you use Core Animation, you’ll use CALayer’s cornerRadius property instead of clipping.
        
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: .allCorners, cornerRadii: Constants.cornerRadiusSize)
        path.addClip()
        
        guard let context = UIGraphicsGetCurrentContext() else { return }
        let colors = [startColor.cgColor, endColor.cgColor]
        
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        
        let colorLocations: [CGFloat] = [0.0, 1.0]
        
        guard let gradient = CGGradient(colorsSpace: colorSpace, colors: colors as CFArray, locations: colorLocations) else { return }
        
        let startPoint = CGPoint.zero
        let endPoint = CGPoint(x: 0, y: bounds.height)
        context.drawLinearGradient(gradient, start: startPoint, end: endPoint, options: [])
        
        let margin = Constants.margin
        let graphWidth = width - margin * 2 - 4
        
        let columnXPoint = { (column: Int) -> CGFloat in
            // Calculate the gap between points
            let spacing = graphWidth / CGFloat(self.graphPoints.count - 1)
            return CGFloat(column) * spacing + margin + 2
        }
        
        // Calculate the y point
        
        let topBorder = Constants.topBorder
        let bottomBorder = Constants.bottomBorder
        let graphHeight = height - topBorder - bottomBorder
        guard let maxValue = graphPoints.max() else { return }
        
        let columnYPoint = { (graphPoint: Int) -> CGFloat in
            let yPoint = CGFloat(graphPoint) / CGFloat(maxValue) * graphHeight
            return graphHeight + topBorder - yPoint // Flip the graph
            /// The above is necessary because the origin in CG is in the top-left corner and ou draw a graph from an origin point in the
            /// bottom-left corner, columnYPoint adjusts its return value so that the graph is oriented as you would expect.
        }
        
        // Draw the line graph
        
        UIColor.white.setFill()
        UIColor.white.setStroke()
        
        let graphPath = UIBezierPath()
        
        graphPath.move(to: CGPoint(x: columnXPoint(0), y: columnYPoint(graphPoints[0])))
        
        // Add the points for each item in the graphPoints array at the correct (x, y) for the point
        for i in 1..<graphPoints.count {
            let nextPoint = CGPoint(x: columnXPoint(i), y: columnYPoint(graphPoints[i]))
            graphPath.addLine(to: nextPoint)
        }
        
        graphPath.stroke()
        
        // MARK: - Creating a gradient for the graph
        
//        context.saveGState()
        
        guard let clippingPath = graphPath.copy() as? UIBezierPath else { return }
        
        clippingPath.addLine(to: CGPoint(x: columnXPoint(graphPoints.count - 1), y: height))
        clippingPath.addLine(to: CGPoint(x: columnXPoint(0), y: height))
        clippingPath.close()
        
        clippingPath.addClip()
        
        let highestYPoint = columnYPoint(maxValue)
        let graphStartPoint = CGPoint(x: margin, y: highestYPoint)
        let graphEndPoint = CGPoint(x: margin, y: bounds.height)
        
        context.drawLinearGradient(gradient, start: graphStartPoint, end: graphEndPoint, options: [])
        graphPath.lineWidth = 2.0
        graphPath.stroke()
    }

}
