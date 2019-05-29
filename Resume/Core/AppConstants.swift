//
//  AppConstants.swift
//  Resume
//
//  Created by Matthew Canoy on 5/27/19.
//  Copyright © 2019 luckybutter. All rights reserved.
//

import UIKit

enum AppConstant {
    static func quickFont(family: FontFamily, weight:FontWeight?) -> UIFont {
        var fontName = family.rawValue
        
        if let weight = weight {
            fontName += "-\(weight.rawValue)"
        }
        
        guard let font = UIFont(name: fontName, size: 12) else {
            return UIFont.systemFont(ofSize: 12)
        }
        
        return font
    }
    
    enum FontFamily : String {
        case lato = "Lato"
    }
    
    enum FontWeight : String {
        case italic = "Italic"
        case black = "Black"
        case blackItalic = "BlackItalic"
        case bold = "Bold"
        case boldItalic = "BoldItalic"
        case light = "Light"
        case lightItalic = "LightItalic"
        case regular = "Regular"
        case hairline = "Hairline"
        case hairlineItalic = "HairlineItalic"
    }
}
