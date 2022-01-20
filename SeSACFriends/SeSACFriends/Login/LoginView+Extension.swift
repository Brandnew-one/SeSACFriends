//
//  LoginView+Extension.swift
//  SeSACFriends
//
//  Created by 신상원 on 2022/01/19.
//

import UIKit

// LoginViewController TextField Extension
extension LoginViewController: UITextFieldDelegate {
    
    // 정규 표현식 테스트 함수
    func checkExpression(text: String) -> Bool {
        let pattern = "^01([0-9])-([0-9]{4})-([0-9]{4})$"
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
            loginView.phoneNumberTextField.setupMode(mode: .focus)
        } else {
            if checkExpression(text: inputString) {
                loginView.phoneNumberTextField.setupMode(mode: .success)
                loginView.phoneNumberTextField.additionLabel.text = "올바른 전화번호 입니다"
                loginView.myButton.setupMode(mode: .fill)
            } else {
                loginView.phoneNumberTextField.setupMode(mode: .error)
                loginView.phoneNumberTextField.additionLabel.text = "잘못된 전화번호 입니다"
                loginView.myButton.setupMode(mode: .disable)
            }
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        loginView.phoneNumberTextField.setupMode(mode: .inactive)
    }
}

extension String {
    func pretty() -> String {
        let str = self.replacingOccurrences(of: "-", with: "")
        let arr = Array(str)
        if arr.count > 3 {
            if let regex = try? NSRegularExpression(pattern: "([0-9]{3})([0-9]{4})([0-9]{4})", options: .caseInsensitive) {
                let modString = regex.stringByReplacingMatches(in: str, options: [], range: NSRange(str.startIndex..., in: str), withTemplate: "$1-$2-$3")
                return modString
            }
        }
        return self
    }
}
