//
//  LoginViewController.swift
//  SeSACFriends
//
//  Created by 신상원 on 2022/01/19.
//

import UIKit

//키보드 타입 변경하기!
class LoginViewController: UIViewController {
    
    let loginViewModel = LoginViewModel()
    let loginView = LoginView()
    
    override func loadView() {
        view = loginView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view?.backgroundColor = .white
        loginView.phoneNumberTextField.textField.delegate = self
        
        // 탭하면 키보드 사라지도록 구현
        let tapGesture = UITapGestureRecognizer(target: view, action: #selector(view.endEditing))
        loginView.phoneNumberTextField.textField.keyboardType = .numberPad
        view.addGestureRecognizer(tapGesture)
    }
    
    
}

extension LoginViewController: UITextFieldDelegate {
    
    // 정규 표현식 테스트 함수
    func checkExpression(text: String) -> Bool {
        let pattern = "^01([0-9])([0-9]{4})([0-9]{4})$"
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
            } else {
                loginView.phoneNumberTextField.setupMode(mode: .error)
                loginView.phoneNumberTextField.additionLabel.text = "잘못된 전화번호 입니다"
            }
        }
    }
    
    // 한 박자 늦게 데이터가 반영되는 문제점
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {

//        print(#function, textField.text, "string: ", string)
        guard let inputString = textField.text else { return true }
        
        //delete Button 을 누르는 경우, ""이 string 값으로 들어간다.
        var newString: String
        //""(지우기) 버튼이 눌리면 임의로 지워서 줌
        if string.isEmpty {
            if inputString.count >= 2 {
                let endIdx: String.Index = inputString.index(inputString.startIndex, offsetBy: inputString.count - 2)
                newString = String(inputString[...endIdx])
            } else {
                newString = inputString
            }
        } else {
            newString = inputString + string //제일 최근에 입력한 문자도 추가
        }
        
        if checkExpression(text: newString) {
//            print("SUC:", newString)
            loginView.phoneNumberTextField.setupMode(mode: .success)
            loginView.phoneNumberTextField.additionLabel.text = "올바른 전화번호 입니다"
        } else {
//            print("ERR:", newString)
            loginView.phoneNumberTextField.setupMode(mode: .error)
            loginView.phoneNumberTextField.additionLabel.text = "잘못된 전화번호 입니다"
        }
        return true
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        loginView.phoneNumberTextField.setupMode(mode: .inactive)
    }
    
    
}
