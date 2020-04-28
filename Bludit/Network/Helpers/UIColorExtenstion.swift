//
//  UIColorExtenstion.swift
//  Bludit
//
//  Created by Viktor Gordienko on 4/28/20.
//  Copyright © 2020 Viktor Gordienko. All rights reserved.
//

import UIKit

/// Convert UIColor to Webcolor
extension UIColor {
    /// For UIColor.blue returns (0.0, 0.0, 1.0, 1.0)
    var rgba: (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) {
        var r: CGFloat = 0, g: CGFloat = 0, b: CGFloat = 0, a: CGFloat = 0
        if getRed(&r, green: &g, blue: &b, alpha: &a) {
            return (r,g,b,a)
        }
        return (0, 0, 0, 0)
    }
    /// For UIColor.blue returns (0.666666666666667, 1.0, 1.0, 1.0)
    var hsba: (hue: CGFloat, saturation: CGFloat, brightness: CGFloat, alpha: CGFloat) {
        var hue: CGFloat = 0, saturation: CGFloat = 0, brightness: CGFloat = 0, alpha: CGFloat = 0
        if getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha) {
            return (hue, saturation, brightness, alpha)
        }
        return (0,0,0,0)
    }
    /// Converts UIColor.blue to "#0000ff"
    var htmlRGB: String {
        return String(format: "#%02x%02x%02x", Int(rgba.red * 255), Int(rgba.green * 255), Int(rgba.blue * 255))
    }
    /// Converts UIColor.blue to "#0000ffff"
    var htmlRGBA: String {
        return String(format: "#%02x%02x%02x%02x", Int(rgba.red * 255), Int(rgba.green * 255), Int(rgba.blue * 255), Int(rgba.alpha * 255) )
    }
}
