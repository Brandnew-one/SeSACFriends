//
//  NicknameView+Extension.swift
//  SeSACFriends
//
//  Created by 신상원 on 2022/01/21.
//

import UIKit

extension NicknameViewController: UITextFieldDelegate {
    
    // 정규 표현식 테스트 함수
    func checkExpression(text: String) -> Bool {
        if text.count >= 1 && text.count <= 10 {
            return true
        } else {
            return false
        }
    }
    
    // 사용자가 텍스트필드를 터치하는 경우 focus
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        guard let inputString = textField.text else { return }
        if inputString.isEmpty {
            loginView.phoneNumberTextField.setupMode(mode: .focus)
        } else {
            if checkExpression(text: inputString) {
                loginView.phoneNumberTextField.setupMode(mode: .success)
                loginView.phoneNumberTextField.additionLabel.text = "올바른 형식입니다"
                loginView.myButton.setupMode(mode: .fill)
            } else {
                loginView.phoneNumberTextField.setupMode(mode: .error)
                loginView.phoneNumberTextField.additionLabel.text = "닉네임은 1자 이상 10자 이내로 작성해주세요"
                loginView.myButton.setupMode(mode: .disable)
            }
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        loginView.phoneNumberTextField.setupMode(mode: .inactive)
    }
    
}
