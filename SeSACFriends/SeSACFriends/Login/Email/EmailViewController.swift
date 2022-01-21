//
//  EmailViewController.swift
//  SeSACFriends
//
//  Created by 신상원 on 2022/01/21.
//

import SnapKit
import UIKit

class EmailViewController: UIViewController {
    
    let emailView = EmailView()
    
    override func loadView() {
        view = emailView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setText()
        
        // 탭하면 키보드 사라지도록 구현
        let tapGesture = UITapGestureRecognizer(target: view, action: #selector(view.endEditing))
        view.addGestureRecognizer(tapGesture)
        
        emailView.loginView.phoneNumberTextField.textField.delegate = self
        
        emailView.loginView.phoneNumberTextField.textField.addTarget(self, action: #selector(textFieldDidchanged(_:)), for: .editingChanged)
        emailView.loginView.myButton.addTarget(self, action: #selector(nextButtonClicked), for: .touchUpInside)
    }
    
    func setText() {
        emailView.loginView.textLabel.text = "이메일을 입력해주세요"
        emailView.subLabel.text = "휴대폰 번호 변경 시 인증을 위해서 사용해요"
        emailView.loginView.phoneNumberTextField.textField.placeholder = "10자리 이내로 입력"
        emailView.loginView.myButton.setTitle("다음", for: .normal)
    }
    
    @objc func textFieldDidchanged(_ textField: UITextField) {
        if checkExpression(text: textField.text ?? "") {
            emailView.loginView.phoneNumberTextField.setupMode(mode: .success)
            emailView.loginView.phoneNumberTextField.additionLabel.text = "올바른 형식입니다"
            emailView.loginView.myButton.setupMode(mode: .fill)
        } else {
            emailView.loginView.phoneNumberTextField.setupMode(mode: .error)
            emailView.loginView.phoneNumberTextField.additionLabel.text = "이메일 형식이 올바르지 않습니다"
            emailView.loginView.myButton.setupMode(mode: .disable)
        }
    }
    
    @objc func nextButtonClicked() {
        if emailView.loginView.myButton.mode == .fill {
            LoginViewModel.shared.nick.value = emailView.loginView.phoneNumberTextField.textField.text!
            let vc = GenderViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        } else {
            self.view.endEditing(true)
            self.view.makeToast("이메일 형식이 올바르지 않습니다")
        }
    }
    
}
