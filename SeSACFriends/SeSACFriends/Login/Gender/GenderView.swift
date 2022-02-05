//
//  GenderView.swift
//  SeSACFriends
//
//  Created by 신상원 on 2022/01/21.
//

import SnapKit
import UIKit

class GenderView: UIView, ViewRepresentable {
    
    let mainLabel = UILabel()
    let subLabel = UILabel()
    
    let maleView = GenderImageView()
    let femaleView = GenderImageView()
    
    let myButton = MyButton(frame: CGRect(), mode: .disable, text: "다음")
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func setupView() {
        [mainLabel, subLabel, maleView, femaleView, myButton].forEach {
            self.addSubview($0)
        }
        mainLabel.font = FontSet.displayR20
        mainLabel.textColor = UIColor(rgbString: ColorSet.black)
        mainLabel.textAlignment = .center
        
        subLabel.font = FontSet.title2R16
        subLabel.textColor = UIColor(rgbString: ColorSet.gray7)
        subLabel.textAlignment = .center
        
        maleView.layer.borderColor = UIColor(rgbString: ColorSet.gray3).cgColor
        maleView.layer.borderWidth = 1
        maleView.clipsToBounds = true
        maleView.layer.cornerRadius = 8
        maleView.imageView.image = UIImage(named: ImageSet.man)
        
        femaleView.layer.borderColor = UIColor(rgbString: ColorSet.gray3).cgColor
        femaleView.layer.borderWidth = 1
        femaleView.clipsToBounds = true
        femaleView.layer.cornerRadius = 8
        femaleView.imageView.image = UIImage(named: ImageSet.woman)
    }
    
    func setupConstraints() {
        mainLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(169)
            make.leading.equalToSuperview().offset(74)
            make.trailing.equalToSuperview().offset(-74)
        }
        
        subLabel.snp.makeConstraints { make in
            make.top.equalTo(mainLabel.snp.bottom).offset(8)
            make.leading.equalToSuperview().offset(40)
            make.trailing.equalToSuperview().offset(-40)
        }
        
        maleView.snp.makeConstraints { make in
            make.top.equalTo(subLabel.snp.bottom).offset(32)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalTo(femaleView.snp.leading).offset(-16)
            make.height.equalTo(120)
        }
        
        femaleView.snp.makeConstraints { make in
            make.top.equalTo(subLabel.snp.bottom).offset(32)
            make.trailing.equalToSuperview().offset(-16)
            make.width.equalTo(maleView)
            make.height.equalTo(120)
        }
        
        myButton.snp.makeConstraints { make in
            make.top.equalTo(maleView.snp.bottom).offset(32)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(48)
        }
    }
    
}
