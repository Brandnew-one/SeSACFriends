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
        
        loginView.myButton.addTarget(self, action: #selector(buttonClicked), for: .touchUpInside)
    }
    
    @objc func buttonClicked() {
        // 올바른 전화번호를 입력한 경우 -> 화면전환
        if loginView.myButton.mode == .fill {
            let vc = CertificationViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        } else {
            self.view.makeToast("잘못된 전화번호 형식입니다")
        }
    }
    
}

