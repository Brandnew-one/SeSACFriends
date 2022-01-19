//
//  ColorSet.swift
//  SeSACFriends
//
//  Created by 신상원 on 2022/01/18.
//

import UIKit

struct ColorSet {
    
    //Black & White
    static let white = "FFFFFF"
    static let black = "333333"
    
    //Brand Color
    static let green = "49DC92"
    static let whiteGreen = "CDF4E1"
    static let yellowGreen = "B2EB61"
    
    //GrayScle
    static let gray7 = "888888"
    static let gray6 = "AAAAAA"
    static let gray5 = "BDBDBD"
    static let gray4 = "D1D1D1"
    static let gray3 = "E2E2E2"
    static let gray2 = "EFEFEF"
    static let gray1 = "F7F7F7"
    
    //systemColor
    static let successColor = "628FE5"
    static let errorColor = "E9666B"
    static let focusColor = "333333"
    
}

extension UIColor {
    
    convenience init(red: Int, green: Int, blue: Int, a: Int = 0xFF) {
       self.init(
           red: CGFloat(red) / 255.0,
           green: CGFloat(green) / 255.0,
           blue: CGFloat(blue) / 255.0,
           alpha: CGFloat(a) / 255.0
       )
    }
    
    convenience init(rgbString: String) {
        let rgb: Int = Int(rgbString, radix: 16) ?? 0
        self.init(
            red: (rgb >> 16) & 0xFF,
            green: (rgb >> 8) & 0xFF,
            blue: rgb & 0xFF
        )
    }
}


