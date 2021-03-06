//
//  CustomButton.swift
//  SeSACFriends
//
//  Created by 신상원 on 2022/01/18.
//

import SnapKit
import UIKit

enum ButtonMode: Int {
    case inactive
    case fill
    case outline
    case cancel
    case disable
}

class MyButton: UIButton {

    var mode: ButtonMode
    var text: String

    init(frame: CGRect, mode: ButtonMode, text: String) {
        self.mode = mode
        self.text = text
        super.init(frame: frame)
        setupView(text: text)
        setupMode(mode: mode)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func setupView(text: String) {
        clipsToBounds = true
        layer.cornerRadius = 8
        layer.borderWidth = 1
        setTitle(text, for: .normal)
        titleLabel?.font = FontSet.body3R14

    }
    
    func setupMode(mode: ButtonMode) {
        self.mode = mode
        switch self.mode {
        case .inactive:
            backgroundColor = UIColor.init(rgbString: ColorSet.white)
            layer.borderColor = UIColor(rgbString: ColorSet.gray4).cgColor
            setTitleColor(UIColor.init(rgbString: ColorSet.black), for: .normal)
        case .fill:
            backgroundColor = UIColor.init(rgbString: ColorSet.green)
            layer.borderColor = UIColor(rgbString: ColorSet.green).cgColor
            setTitleColor(UIColor.init(rgbString: ColorSet.white), for: .normal)
        case .outline:
            backgroundColor = UIColor.init(rgbString: ColorSet.white)
            layer.borderColor = UIColor(rgbString: ColorSet.whiteGreen).cgColor
            setTitleColor(UIColor.init(rgbString: ColorSet.whiteGreen), for: .normal)
        case .cancel:
            backgroundColor = UIColor.init(rgbString: ColorSet.gray2)
            layer.borderColor = UIColor(rgbString: ColorSet.gray2).cgColor
            setTitleColor(UIColor.init(rgbString: ColorSet.black), for: .normal)
        case .disable:
            backgroundColor = UIColor.init(rgbString: ColorSet.gray6)
            layer.borderColor = UIColor(rgbString: ColorSet.gray6).cgColor
            setTitleColor(UIColor.init(rgbString: ColorSet.white), for: .normal)
        }
    }
    
}
