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
        setupView(mode: mode, text: text)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    //CustomTextField 와 달리 setupMode 로 분리 하지 않은 상태 -> 테스트 하고 바꾸기
    func setupView(mode: ButtonMode, text: String) {
        clipsToBounds = true
        layer.cornerRadius = 8
        self.mode = mode
        setTitle(text, for: .normal)
        titleLabel?.font = FontSet.body3R14
        
        switch self.mode {
        case .inactive:
            backgroundColor = UIColor.init(rgbString: ColorSet.white)
            setTitleColor(UIColor.init(rgbString: ColorSet.black), for: .normal)
        case .fill:
            backgroundColor = UIColor.init(rgbString: ColorSet.green)
            setTitleColor(UIColor.init(rgbString: ColorSet.white), for: .normal)
        case .outline:
            backgroundColor = UIColor.init(rgbString: ColorSet.white)
            layer.borderWidth = 1
            layer.borderColor = UIColor(rgbString: ColorSet.whiteGreen).cgColor
            setTitleColor(UIColor.init(rgbString: ColorSet.whiteGreen), for: .normal)
        case .cancel:
            backgroundColor = UIColor.init(rgbString: ColorSet.gray2)
            setTitleColor(UIColor.init(rgbString: ColorSet.black), for: .normal)
        case .disable:
            backgroundColor = UIColor.init(rgbString: ColorSet.gray6)
            setTitleColor(UIColor.init(rgbString: ColorSet.white), for: .normal)
        }
        
    }
}
