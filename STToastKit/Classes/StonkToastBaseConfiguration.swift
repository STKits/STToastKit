//
//  StonkToastBaseConfiguration.swift
//  StonkCommonKit
//
//  Created by yuanbin on 1/15/25.
//

import Foundation

public protocol StonkToastBaseConfiguration {
    var type: StonkToastType { get set }
    var initialTransform: CGAffineTransform { get set }
    var superView: UIView? { get set }
    var showDuration: StonkToastDuration  { get set }
    var delay: TimeInterval { get set }
    var duration: StonkToastDuration { get set }
    var hideDuration: StonkToastDuration { get set }
    var isTapToDissmiss: Bool { get set }
}

public enum StonkToastType {
    case toast
    case banner
}

public enum StonkToastCornerType {
    case round
    case custom(radius: CGFloat)
}

public enum StonkToastDuration {
   case infinite
   case long
   case normal
   case short
   
    public var value: TimeInterval {
       switch self {
       case .infinite:
           return -1
       case .long:
           return 6.0
       case .normal:
           return 3.0
       case .short:
           return 0.3
       }
   }
}

extension UIColor {
    class func make(light: UIColor, dark: UIColor) -> UIColor {
        return UIColor { (traitCollection) -> UIColor in
            return UITraitCollection.current.userInterfaceStyle == .light ? light : dark
        }
    }
    
    static func rgba(
        _ red: CGFloat,
        _ green: CGFloat,
        _ blue: CGFloat,
        _ alpha: CGFloat
    ) -> UIColor {
        return UIColor(r: red, g: green, b: blue, a: alpha)
    }
    
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat = 1.0) {
        assert(r >= 0 && r <= 255, "Invalid red component")
        assert(g >= 0 && g <= 255, "Invalid green component")
        assert(b >= 0 && b <= 255, "Invalid blue component")
        self.init(
            red: CGFloat(r) / 255.0,
            green: CGFloat(g) / 255.0,
            blue: CGFloat(b) / 255.0,
            alpha: a)
    }
}
