//
//  ReviewPopupView.swift
//  SeSACFriends
//
//  Created by 신상원 on 2022/02/20.
//

import SnapKit
import UIKit

class ReviewPopupView: UIView, ViewRepresentable {
    
    var contentView = UIView()
    var titleLabel = UILabel()
    var closeButton = UIButton()
    var contentLabel = UILabel()
    
    // 좌 -> 우, 상 -> 하 순으로 설정
    var buttonView = UIView()
    var mybutton1 = MyButton(frame: CGRect(), mode: .inactive, text: "좋은매너")
    var mybutton2 = MyButton(frame: CGRect(), mode: .inactive, text: "정확한 시간 약속")
    var mybutton3 = MyButton(frame: CGRect(), mode: .inactive, text: "빠른 응답")
    var mybutton4 = MyButton(frame: CGRect(), mode: .inactive, text: "친절한 성격")
    var mybutton5 = MyButton(frame: CGRect(), mode: .inactive, text: "능숙한 취미 실력")
    var mybutton6 = MyButton(frame: CGRect(), mode: .inactive, text: "유익한 시간")
    
    var textView = UITextView()
    var finalButton = MyButton(frame: CGRect(), mode: .disable, text: "리뷰 등록하기")
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func setupView() {
        [contentView, buttonView, textView, finalButton].forEach {
            self.addSubview($0)
        }
        textView.backgroundColor = UIColor(rgbString: ColorSet.gray1)
        textView.font = FontSet.body3R14
        textView.clipsToBounds = true
        textView.layer.cornerRadius = 8
        
        [titleLabel, closeButton, contentLabel].forEach {
            contentView.addSubview($0)
        }
        titleLabel.font = FontSet.title3M14
        titleLabel.textColor = UIColor(rgbString: ColorSet.black)
        titleLabel.textAlignment = .center
        titleLabel.text = "리뷰등록"
        closeButton.setImage(UIImage(named: ImageSet.closeGray), for: .normal)
        contentLabel.font = FontSet.title4R14
        contentLabel.textColor = UIColor(rgbString: ColorSet.green)
        contentLabel.textAlignment = .center
        contentLabel.text = "고래밥님과의 취미할동은 어떠셨나요?"
        
        [mybutton1, mybutton2, mybutton3, mybutton4, mybutton5, mybutton6].forEach {
            buttonView.addSubview($0)
        }
    }
    
    func setupConstraints() {
        finalButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.trailing.bottom.equalToSuperview().offset(-16)
            make.height.equalTo(48)
        }
        
        textView.snp.makeConstraints { make in
            make.bottom.equalTo(finalButton.snp.top).offset(-24)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(124)
        }
        
        contentView.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(62)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(1)
            make.centerX.equalToSuperview()
        }
        
        closeButton.snp.makeConstraints { make in
            make.top.trailing.equalToSuperview()
            make.width.height.equalTo(24)
        }
        
        contentLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(17)
            make.centerX.bottom.equalToSuperview()
        }
        
        buttonView.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.bottom).offset(24)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(112)
        }
        
        mybutton1.snp.makeConstraints { make in
            make.top.leading.equalToSuperview()
            make.width.equalTo(mybutton2.snp.width)
            make.trailing.equalTo(mybutton2.snp.leading).offset(-8)
            make.height.equalTo(32)
        }
        
        mybutton2.snp.makeConstraints { make in
            make.top.trailing.equalToSuperview()
            make.height.equalTo(32)
        }
        
        mybutton3.snp.makeConstraints { make in
            make.top.equalTo(mybutton1.snp.bottom).offset(8)
            make.leading.equalToSuperview()
            make.width.equalTo(mybutton4.snp.width)
            make.trailing.equalTo(mybutton4.snp.leading).offset(-8)
            make.height.equalTo(32)
        }
        
        mybutton4.snp.makeConstraints { make in
            make.top.equalTo(mybutton2.snp.bottom).offset(8)
            make.trailing.equalToSuperview()
            make.height.equalTo(32)
        }
        
        mybutton5.snp.makeConstraints { make in
            make.top.equalTo(mybutton3.snp.bottom).offset(8)
            make.leading.equalToSuperview()
            make.width.equalTo(mybutton6.snp.width)
            make.trailing.equalTo(mybutton6.snp.leading).offset(-8)
            make.height.equalTo(32)
        }
        
        mybutton6.snp.makeConstraints { make in
            make.top.equalTo(mybutton4.snp.bottom).offset(8)
            make.trailing.equalToSuperview()
            make.height.equalTo(32)
        }
    }

    
}
