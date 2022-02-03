//
//  TitleView.swift
//  SeSACFriends
//
//  Created by 신상원 on 2022/01/31.
//

import SnapKit
import UIKit

// 카드 새싹 타이틀 뷰
class TitleView: UIView {
    
    var label = UILabel()
    var title = ""
    var isOn = false
    
    
    init(frame: CGRect, title: String, isOn: Bool) {
        self.title = title
        self.isOn = isOn
        super.init(frame: frame)
        
        setupView(title: title)
        setupConstraints()
        setupMode(isOn: isOn)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func setupView(title: String) {
        self.addSubview(label)
        self.clipsToBounds = true
        self.layer.cornerRadius = 8
        
        label.font = FontSet.title4R14
        label.text = title
        label.textAlignment = .center
    }
    
    func setupConstraints() {
        label.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(5)
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-5)
        }
    }
    
    func setupMode(isOn: Bool) {
        // 타이틀을 가지는 경우
        if isOn {
            self.backgroundColor = UIColor(rgbString: ColorSet.green)
            self.layer.borderWidth = 0
            label.textColor = UIColor(rgbString: ColorSet.white)
        } else {
            //타이틀을 가지지 못한 경우
            self.backgroundColor = UIColor(rgbString: ColorSet.white)
            self.layer.borderWidth = 1
            self.layer.borderColor = UIColor(rgbString: ColorSet.gray4).cgColor
            label.textColor = UIColor(rgbString: ColorSet.black)
        }
    }
}

