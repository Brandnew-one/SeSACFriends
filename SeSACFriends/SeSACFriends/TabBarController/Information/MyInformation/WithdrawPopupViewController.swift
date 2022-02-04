//
//  WithdrawPopupViewController.swift
//  SeSACFriends
//
//  Created by 신상원 on 2022/02/04.
//

import SnapKit
import UIKit

class WithdrawPopupViewController: UIViewController, ViewRepresentable {
    
    var popupView = UIView()
    var titleLabel = UILabel()
    var contentLabel = UILabel()
    var okButtoon = MyButton(frame: CGRect(), mode: .fill, text: "확인")
    var cancleButton = MyButton(frame: CGRect(), mode: .cancel, text: "취소")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black.withAlphaComponent(0.5)
        setupView()
        setupConstraints()
        
        okButtoon.addTarget(self, action: #selector(okButtonClicked), for: .touchUpInside)
        cancleButton.addTarget(self, action: #selector(cancleButtonClicked), for: .touchUpInside)
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
                windowScene.windows.first?.rootViewController = UINavigationController(rootViewController: LoginViewController())
                windowScene.windows.first?.makeKeyAndVisible()
            } else {
                self.view.makeToast("네트워크 오류입니다")
            }
        }
    }
    
    func setupView() {
        view.addSubview(popupView)
        popupView.backgroundColor = UIColor(rgbString: ColorSet.white)
        popupView.clipsToBounds = true
        popupView.layer.cornerRadius = 16
        
        [titleLabel, contentLabel, okButtoon, cancleButton].forEach {
            popupView.addSubview($0)
        }
        
        titleLabel.textColor = UIColor(rgbString: ColorSet.black)
        titleLabel.textAlignment = .center
        titleLabel.font = FontSet.body1M16
        titleLabel.text = "정말 탈퇴하시겠습니까?"
        
        contentLabel.textColor = UIColor(rgbString: ColorSet.black)
        contentLabel.textAlignment = .center
        contentLabel.font = FontSet.title4R14
        contentLabel.text = "탈퇴하시면 새싹 프렌즈를 이용할 수 없어요ㅠ"
    }
    
    func setupConstraints() {
        popupView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.centerY.equalToSuperview()
            make.height.equalTo(156)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
        
        contentLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
        
        cancleButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.bottom.equalToSuperview().offset(-16)
            make.trailing.equalTo(okButtoon.snp.leading).offset(-8)
            make.width.equalTo(okButtoon)
            make.height.equalTo(48)
        }
        
        okButtoon.snp.makeConstraints { make in
            make.bottom.trailing.equalToSuperview().offset(-16)
            make.width.equalTo(cancleButton)
            make.height.equalTo(48)
        }
    }
    
}
