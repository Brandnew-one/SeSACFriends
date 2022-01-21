//
//  EmailView+Extension.swift
//  SeSACFriends
//
//  Created by 신상원 on 2022/01/21.
//

import UIKit

extension EmailViewController: UITextFieldDelegate {
    
    // 정규 표현식 테스트 함수
    func checkExpression(text: String) -> Bool {
        let pattern = "^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,20}$"
        let regex = try? NSRegularExpression(pattern: pattern)
        
        if let _ = regex?.firstMatch(in: text, options: [], range: NSRange(location: 0, length: text.count)) {
            return true
        } else {
            return false
        }
    }
    
    // 사용자가 텍스트필드를 터치하는 경우 focus
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        guard let inputString = textField.text else { return }
        if inputString.isEmpty {
            emailView.loginView.phoneNumberTextField.setupMode(mode: .focus)
        } else {
            if checkExpression(text: inputString) {
                emailView.loginView.phoneNumberTextField.setupMode(mode: .success)
                emailView.loginView.phoneNumberTextField.additionLabel.text = "올바른 형식입니다"
                emailView.loginView.myButton.setupMode(mode: .fill)
            } else {
                emailView.loginView.phoneNumberTextField.setupMode(mode: .error)
                emailView.loginView.phoneNumberTextField.additionLabel.text = "이메일 형식이 올바르지 않습니다"
                emailView.loginView.myButton.setupMode(mode: .disable)
            }
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        emailView.loginView.phoneNumberTextField.setupMode(mode: .inactive)
    }
    
}
