//
//  MyCardView.swift
//  SeSACFriends
//
//  Created by 신상원 on 2022/01/27.
//

import SnapKit
import UIKit

class MyCardView: UIView, ViewRepresentable {
    
    let backgroundImageView = UIImageView()
    let sesacImageView = UIImageView()
    let toggleView = ToggleView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func setupView() {
        [backgroundImageView, sesacImageView, toggleView].forEach {
            self.addSubview($0)
        }
        backgroundImageView.image = UIImage(named: "sesac_bg_01")
        backgroundImageView.clipsToBounds = true
        backgroundImageView.layer.cornerRadius = 8
        sesacImageView.image = UIImage(named: "sesac_face_2")
        
        toggleView.clipsToBounds = true
        toggleView.layer.cornerRadius = 8
        toggleView.layer.borderWidth = 1
        toggleView.layer.borderColor = UIColor(rgbString: ColorSet.gray2).cgColor
    }
    
    func setupConstraints() {
        backgroundImageView.snp.makeConstraints { make in
            make.top.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.equalTo(194)
        }
        
        sesacImageView.snp.makeConstraints { make in
            make.top.equalTo(backgroundImageView).offset(19)
            make.leading.equalTo(backgroundImageView).offset(75)
            make.trailing.equalTo(backgroundImageView).offset(-84)
            make.height.equalTo(184)
        }
        
        toggleView.snp.makeConstraints { make in
            make.top.equalTo(backgroundImageView.snp.bottom)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
//            make.height.equalTo(58)
        }
        
    }
    
}

class ToggleView: UIView, ViewRepresentable {
    
    let nameLabel = UILabel()
    var toggleButton = UIButton()
    let titleView = sesacTitleView()
    let reviewView = sesacReviewView(frame: CGRect(), review: nil)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func setupView() {
        [nameLabel, toggleButton, titleView, reviewView].forEach {
            self.addSubview($0)
        }
        nameLabel.textColor = UIColor(rgbString: ColorSet.black)
        nameLabel.font = FontSet.title1M16
        nameLabel.text = "신상원"
        toggleButton.setImage(UIImage(named: "more_arrow-bottom"), for: .normal)
    }
    
    func setupConstraints() {
        nameLabel.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().offset(16)
//            make.bottom.equalToSuperview().offset(-16)
        }
        
        toggleButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(26)
            make.trailing.equalToSuperview().offset(-18)
            make.width.equalTo(12)
            make.height.equalTo(12)
        }
        
        titleView.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(24)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(146)
        }
        
        reviewView.snp.makeConstraints { make in
            make.top.equalTo(titleView.snp.bottom).offset(24)
            make.leading.equalToSuperview().offset(16)
            make.trailing.bottom.equalToSuperview().offset(-16)
        }
        
    }
}
