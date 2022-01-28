//
//  MyPhoneView.swift
//  SeSACFriends
//
//  Created by 신상원 on 2022/01/26.
//

import SnapKit
import UIKit

class MyPhoneView: UIView, ViewRepresentable {
    
    let label = UILabel()
    let phoneSwitch = UISwitch()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func setupView() {
        [label, phoneSwitch].forEach {
            self.addSubview($0)
        }
        phoneSwitch.tintColor = UIColor(rgbString: ColorSet.green)
        phoneSwitch.onTintColor = UIColor(rgbString: ColorSet.green)
        
        label.textColor = UIColor(rgbString: ColorSet.black)
        label.font = FontSet.title4R14
        label.text = "내 번호 검색 허용"
    }
    
    func setupConstraints() {
        label.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.top.equalToSuperview().offset(13)
            make.bottom.equalToSuperview().offset(-13)
        }
        
        phoneSwitch.snp.makeConstraints { make in
            make.trailing.equalToSuperview()
            make.top.equalToSuperview().offset(10)
            make.bottom.equalToSuperview().offset(-10)
            make.width.equalTo(55)
        }
    }
    
}
