//
//  NicknameViewController.swift
//  SeSACFriends
//
//  Created by 신상원 on 2022/01/21.
//

import SnapKit
import Toast_Swift

import UIKit

class NicknameViewController: UIViewController {
    
    let loginView = LoginView()
    
    override func loadView() {
        view = loginView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setText()
        
        // 탭하면 키보드 사라지도록 구현
        let tapGesture = UITapGestureRecognizer(target: view, action: #selector(view.endEditing))
        view.addGestureRecognizer(tapGesture)
        
        loginView.phoneNumberTextField.textField.delegate = self
        
        loginView.phoneNumberTextField.textField.addTarget(self, action: #selector(textFieldDidchanged(_:)), for: .editingChanged)
        loginView.myButton.addTarget(self, action: #selector(nextButtonClicked), for: .touchUpInside)
    }
    
    @objc func textFieldDidchanged(_ textField: UITextField) {
        if checkExpression(text: textField.text ?? "") {
            loginView.phoneNumberTextField.setupMode(mode: .success)
            loginView.phoneNumberTextField.additionLabel.text = "올바른 형식입니다"
            loginView.myButton.setupMode(mode: .fill)
        } else {
            loginView.phoneNumberTextField.setupMode(mode: .error)
            loginView.phoneNumberTextField.additionLabel.text = "닉네임은 1자 이상 10자 이내로 작성해주세요"
            loginView.myButton.setupMode(mode: .disable)
        }
    }
    
    @objc func nextButtonClicked() {
        if loginView.myButton.mode == .fill {
            LoginViewModel.shared.nick.value = loginView.phoneNumberTextField.textField.text!
            let vc = CertificationViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        } else {
            self.view.endEditing(true)
            self.view.makeToast("닉네임은 1자 이상 10자 이내로 작성해주세요")
        }
    }
    
    func setText() {
        loginView.textLabel.text = "닉네임을 입력해주세요"
        loginView.phoneNumberTextField.textField.placeholder = "10자리 이내로 입력"
        loginView.myButton.setTitle("다음", for: .normal)
    }
    
}
