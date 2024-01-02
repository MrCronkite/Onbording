

import UIKit

extension UIColor {
    
    static let end_gradient = UIColor(named: "end_gradient") ?? UIColor(r: 220, g: 210, b: 100)
    static let backgraund_color = UIColor(named: "backgraund_color") ?? UIColor(r: 220, g: 210, b: 100)
    static let start_gradient = UIColor(named: "start_gradient") ?? UIColor(r: 220, g: 210, b: 100)
    
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat, _ a: CGFloat = 1.0) {
        self.init(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: a)
    }
}
