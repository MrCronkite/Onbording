

import UIKit
import SnapKit

extension UIView {
    func animateGradientColors() {
        let gradient = CAGradientLayer()
        gradient.frame = bounds
        gradient.colors = [UIColor.start_gradient.cgColor, UIColor.end_gradient.cgColor]
        gradient.startPoint = CGPoint(x: 0, y: 0.5)
        gradient.endPoint = CGPoint(x: 1, y: 0.5)
        gradient.zPosition = -1
        layer.addSublayer(gradient)
        
        let animation = CABasicAnimation(keyPath: "colors")
        animation.fromValue = [UIColor.start_gradient.cgColor, UIColor.end_gradient.cgColor]
        animation.toValue = [UIColor.end_gradient.cgColor, UIColor.start_gradient.cgColor]
        animation.duration = 1
        animation.autoreverses = true
        animation.repeatCount = .infinity
        
        gradient.add(animation, forKey: nil)
    }
    
    func removeGradientLayers() {
        layer.sublayers?.forEach {
            if $0 is CAGradientLayer {
                $0.removeFromSuperlayer()
            }
        }
    }
    
    func dropShadow(color: UIColor, opacity: Float = 0.5, offSet: CGSize, radius: CGFloat = 1, cornerRadius: CGFloat = 0, scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset = offSet
        layer.shadowRadius = radius
        
        let shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius).cgPath
        layer.shadowPath = shadowPath
        
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
}
