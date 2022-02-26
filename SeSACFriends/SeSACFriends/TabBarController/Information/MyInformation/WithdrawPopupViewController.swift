//
//  WithdrawPopupViewController.swift
//  SeSACFriends
//
//  Created by 신상원 on 2022/02/04.
//

import SnapKit
import UIKit

class WithdrawPopupViewController: UIViewController, ViewRepresentable {
    
    var popupView = PopupView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black.withAlphaComponent(0.5)
        setupView()
        setupConstraints()
        
        popupView.okButtoon.addTarget(self, action: #selector(okButtonClicked), for: .touchUpInside)
        popupView.cancleButton.addTarget(self, action: #selector(cancleButtonClicked), for: .touchUpInside)
    }
    
    @objc func cancleButtonClicked() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func okButtonClicked() {
        print(#function)
        LoginViewModel.shared.fetchWithdraw { code in
            if code == 200 || code == 406 {
                UserDefaults.standard.removeObject(forKey: "FBToken")
                guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return }
                windowScene.windows.first?.rootViewController = UINavigationController(rootViewController: OnBoardingViewController())
                windowScene.windows.first?.makeKeyAndVisible()
            } else {
                self.view.makeToast("네트워크 오류입니다")
            }
        }
    }
    
    func setupView() {
        view.addSubview(popupView)
    }
    
    func setupConstraints() {
        popupView.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
}
