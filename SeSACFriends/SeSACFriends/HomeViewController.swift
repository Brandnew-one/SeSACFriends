//
//  HomeViewController.swift
//  SeSACFriends
//
//  Created by 신상원 on 2022/01/23.
//

import SnapKit
import Toast_Swift

import UIKit

class HomeViewController: UIViewController {
    
    let button = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(button)
        button.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.height.width.equalTo(150)
        }
        button.setTitle("회원 탈퇴하기", for: .normal)
        button.backgroundColor = .systemCyan
        
        button.addTarget(self, action: #selector(delButtonClicked), for: .touchUpInside)
    }
    
    @objc func delButtonClicked() {
        LoginViewModel.shared.fetchWithdraw { code in
            if code == 200 || code == 406 {
                guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return }
                windowScene.windows.first?.rootViewController = UINavigationController(rootViewController: LoginViewController())
                windowScene.windows.first?.makeKeyAndVisible()
            } else {
                self.view.makeToast("네트워크 오류입니다")
            }
        }
    }
    
}
