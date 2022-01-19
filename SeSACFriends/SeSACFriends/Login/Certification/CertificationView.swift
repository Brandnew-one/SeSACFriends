//
//  CertificationView.swift
//  SeSACFriends
//
//  Created by 신상원 on 2022/01/19.
//

import SnapKit
import UIKit

class CertificationView: UIView, ViewRepresentable {
    
    let mainLabel = UILabel()
    let subLabel = UILabel()
    
    let textField = UITextField()
    let lineView = UIView()
    let timerLabel = UILabel()
    let sendButton = MyButton(frame: CGRect(), mode: .fill, text: "재전송")
    
    let startButton = MyButton(frame: CGRect(), mode: .disable, text: "인증하고 시작하기")
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func setupView() {
        [mainLabel, subLabel, textField, lineView, timerLabel, sendButton, startButton].forEach {
            self.addSubview($0)
        }
        mainLabel.text = "인증번호가 문자로 전송되었어요"
        mainLabel.font = FontSet.displayR20
        mainLabel.textColor = UIColor(rgbString: ColorSet.black)
        mainLabel.textAlignment = .center
        
        subLabel.text = "(최대 소모 20초)"
        subLabel.font = FontSet.title2R16
        subLabel.textColor = UIColor(rgbString: ColorSet.gray7)
        subLabel.textAlignment = .center
        
        textField.font = FontSet.title4R14
        textField.placeholder = "인증번호 입력"
        textField.textColor = UIColor(rgbString: ColorSet.gray7)
        
        timerLabel.text = "05:00"
        timerLabel.font = FontSet.title3M14
        timerLabel.textColor = UIColor(rgbString: ColorSet.green)
    }
    
    func setupConstraints() {
        mainLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(168)
            make.leading.equalToSuperview().offset(57.5)
            make.trailing.equalToSuperview().offset(-57.5)
        }
        
        subLabel.snp.makeConstraints { make in
            make.top.equalTo(mainLabel.snp.bottom).offset(8)
            make.leading.equalToSuperview().offset(132.5)
            make.trailing.equalToSuperview().offset(-132.5)
        }
        
        sendButton.snp.makeConstraints { make in
            make.top.equalTo(subLabel.snp.bottom).offset(69)
            make.trailing.equalToSuperview().offset(-16)
            make.width.equalTo(72)
            make.height.equalTo(40)
        }
        
        lineView.snp.makeConstraints { make in
            make.top.equalTo(textField.snp.bottom).offset(12)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalTo(sendButton.snp.leading).offset(-8)
            make.height.equalTo(1)
        }
        
        timerLabel.snp.makeConstraints { make in
            make.top.equalTo(subLabel.snp.bottom).offset(76)
            make.trailing.equalTo(sendButton.snp.leading).offset(-20)
            make.bottom.equalTo(lineView.snp.top).offset(-12)
        }
        
        textField.snp.makeConstraints { make in
            make.top.equalTo(subLabel.snp.bottom).offset(76)
            make.leading.equalToSuperview().offset(28)
            make.trailing.equalTo(timerLabel.snp.leading).offset(-12)
        }
        
        startButton.snp.makeConstraints { make in
            make.top.equalTo(lineView.snp.bottom).offset(72)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(48)
        }
    }
    
}
