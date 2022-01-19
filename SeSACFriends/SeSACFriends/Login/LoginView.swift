//
//  LoginView.swift
//  SeSACFriends
//
//  Created by 신상원 on 2022/01/18.
//

import SnapKit
import UIKit

class LoginView: UIView, ViewRepresentable {

    let textLabel = UILabel()
    let phoneNumberTextField = CustomTextField(frame: CGRect(), mode: .inactive)
    let myButton = MyButton(frame: CGRect(), mode: .disable, text: "인증 문자 받기")
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func setupView() {
        [textLabel, phoneNumberTextField, myButton].forEach {
            self.addSubview($0)
        }
        phoneNumberTextField.textField.placeholder = "휴대폰 번호(-없이 숫자만 입력)"
        textLabel.text = "새싹 서비스 이용을 위해\n휴대폰 번호를 입력해주세요"
        textLabel.font = FontSet.displayR20
        textLabel.numberOfLines = 2
        textLabel.textAlignment = .center
    }
    
    func setupConstraints() {
        textLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(169)
            make.leading.equalToSuperview().offset(74)
            make.trailing.equalToSuperview().offset(-74)
        }
        
        phoneNumberTextField.snp.makeConstraints { make in
            make.top.equalTo(textLabel.snp.bottom).offset(64)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
        
        myButton.snp.makeConstraints { make in
            make.top.equalTo(phoneNumberTextField.snp.bottom).offset(64)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(48)
        }
    }
    
}
