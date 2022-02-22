//
//  CanclePopupViewController.swift
//  SeSACFriends
//
//  Created by 신상원 on 2022/02/19.
//

import SnapKit
import UIKit

class CanclePopupViewController: UIViewController, ViewRepresentable {

    var mode: VCMode = .accept
    var popupView = PopupView()
    var homeviewModel = HomeViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black.withAlphaComponent(0.5)
        setupView()
        setupConstraints()
        setupText()
        
        popupView.okButtoon.addTarget(self, action: #selector(okButtonClicked), for: .touchUpInside)
        popupView.cancleButton.addTarget(self, action: #selector(cancleButtonClicked), for: .touchUpInside)
    }
    
    @objc func cancleButtonClicked() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func okButtonClicked() {
        print(#function)
        homeviewModel.fetchDodgeHobby(id: homeviewModel.myQueueState.value.matchedUid!) { code in
            print("code: ", code)
            if code == 200 {
                UserDefaults.standard.set(0, forKey: UserDefautlsSet.state)
                guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return }
                windowScene.windows.first?.rootViewController = TabBarController()
                windowScene.windows.first?.makeKeyAndVisible()
            }
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    func setupView() {
        view.addSubview(popupView)
    }
    
    func setupConstraints() {
        popupView.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func setupText() {
        popupView.titleLabel.text = "약속을 취소하시겠습니까?"
        popupView.contentLabel.text = "약속을 취소하시면 패널티가 부과됩니다"
    }
    
    
}
