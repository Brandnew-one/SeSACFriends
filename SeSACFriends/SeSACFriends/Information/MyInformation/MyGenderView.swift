//
//  MyGenderView.swift
//  SeSACFriends
//
//  Created by 신상원 on 2022/01/26.
//

import SnapKit
import UIKit

class MyGenderView: UIView, ViewRepresentable {
    
    let label = UILabel()
    let maleButton = UIButton()
    let femaleButton = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func setupView() {
        [label, maleButton, femaleButton].forEach {
            self.addSubview($0)
        }
        label.textColor = UIColor(rgbString: ColorSet.black)
        label.font = FontSet.title4R14
        maleButton.titleLabel?.font = FontSet.body3R14
        femaleButton.titleLabel?.font = FontSet.body3R14
        
        maleButton.clipsToBounds = true
        maleButton.layer.cornerRadius = 8
        maleButton.layer.borderWidth = 1
        maleButton.layer.borderColor = UIColor(rgbString: ColorSet.gray4).cgColor
        
        femaleButton.clipsToBounds = true
        femaleButton.layer.cornerRadius = 8
        femaleButton.layer.borderWidth = 1
        femaleButton.layer.borderColor = UIColor(rgbString: ColorSet.gray4).cgColor
    }
    
    func setupConstraints() {
        label.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.top.equalToSuperview().offset(13)
            make.bottom.equalToSuperview().offset(-13)
            
        }
        
        femaleButton.snp.makeConstraints { make in
            make.trailing.top.bottom.equalToSuperview()
            make.width.equalTo(56)
        }
        
        maleButton.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.trailing.equalTo(femaleButton.snp.leading).offset(-8)
            make.width.equalTo(56)
        }
    }
    
}
