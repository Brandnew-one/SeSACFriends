//
//  LoginViewController.swift
//  SeSACFriends
//
//  Created by 신상원 on 2022/01/19.
//

import Toast_Swift
import UIKit

//키보드 타입 변경하기!
class LoginViewController: UIViewController {
    
    let loginView = LoginView()
    
    override func loadView() {
        view = loginView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        loginView.phoneNumberTextField.textField.delegate = self
        
        // 탭하면 키보드 사라지도록 구현
        let tapGesture = UITapGestureRecognizer(target: view, action: #selector(view.endEditing))
        loginView.phoneNumberTextField.textField.keyboardType = .numberPad
        view.addGestureRecognizer(tapGesture)
        
        loginView.myButton.addTarget(self, action: #selector(buttonClicked), for: .touchUpInside)
        loginView.phoneNumberTextField.textField.addTarget(self, action: #selector(textFieldDidchaged(_:)), for: .editingChanged)
    }
    
    func changePhoneNumber() -> String {
        let text = loginView.phoneNumberTextField.textField.text!
        let str = "+82" + text.replacingOccurrences(of: "-", with: "")
        return str
    }
    
    @objc func buttonClicked() {
        // 올바른 전화번호를 입력한 경우 -> 화면전환 (viewModel에 전화번호 넣어줌)
        if loginView.myButton.mode == .fill {
            UserDefaults.standard.set(changePhoneNumber(), forKey: "phone") // 전화번호 저장
            LoginViewModel.shared.phoneNumber.value = changePhoneNumber()
            let vc = CertificationViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        } else {
            self.view.makeToast("잘못된 전화번호 형식입니다")
        }
    }
    
    // 유효성 검사에 따른 텍스트 필드 (하이폰 추가를 위해 변경)
    @objc func textFieldDidchaged(_ textField: UITextField) {
        textField.text = (textField.text ?? "").pretty()
        if checkExpression(text: textField.text ?? "") {
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

