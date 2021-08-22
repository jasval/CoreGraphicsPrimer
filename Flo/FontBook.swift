/// Copyright (c) 2021 Razeware LLC

import Foundation
import UIKit

public struct FontBook {
    public enum AvenirNext: String, IsFont {
        public var family: String {
            return "AvenirNext"
        }
        
        public var style: String {
            return self.rawValue.capitalized
        }
        
        case bold
        case demiBold
        case heavy
        case medium
        case regular
        
        public func size(_ size: CGFloat) -> UIFont {
            let fontName = "\(family)-\(style)"
            return UIFont(name: fontName, size: size) ?? UIFont.systemFont(ofSize: size)
        }
    }
}

public extension FontBook {
    static let graphFont = AvenirNext.medium
}
