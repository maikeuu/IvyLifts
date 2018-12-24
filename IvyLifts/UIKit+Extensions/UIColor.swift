//
//  UIColor.swift
//  IvyLifts
//
//  Created by Mike Chu on 12/22/18.
//  Copyright © 2018 Mike Lin. All rights reserved.
//

import UIKit

/// Custom UI Color Library
extension UIColor {
    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
    
    static func CustomGreen() -> UIColor {
        return UIColor.rgb(red: 88, green: 166, blue: 24)
    }
    
    static func CustomBlue() -> UIColor {
        return UIColor.rgb(red: 29, green: 111, blue: 204)
    }
    
    static func CustomLightGray() -> UIColor {
        return UIColor.init(white: 220/255.0, alpha: 1)
    }
    
    static func CustomLighterGray() -> UIColor {
        return UIColor.rgb(red: 236, green: 236, blue: 240)
    }
    
    static func CustomLightestGray() -> UIColor {
        return UIColor.init(white: 247/255.0, alpha: 1)
    }
    
    static func offWhite() -> UIColor {
        return UIColor.init(white: 250/255.0, alpha: 1)
    }
    
    static func disabledColor() -> UIColor {
        return UIColor.init(red: 29/255, green: 111/255, blue: 204/255, alpha: 0.45)
    }
    
}

