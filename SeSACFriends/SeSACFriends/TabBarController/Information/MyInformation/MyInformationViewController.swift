//
//  MyInformationViewController.swift
//  SeSACFriends
//
//  Created by 신상원 on 2022/01/28.
//

import SnapKit
import UIKit

class MyInformationViewController: UIViewController {
    
    var myInfoView = MyInfoView()
    var toggle: Bool = true
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.title = "정보 관리"
        
        let tapGesture = UITapGestureRecognizer(target: view, action: #selector(view.endEditing))
        view.addGestureRecognizer(tapGesture)
        
        setupView()
        myInfoView.myCardView.toggleView.toggleButton.addTarget(self, action: #selector(toggleButtonClicked), for: .touchUpInside)
        myInfoView.myWithdrawView.button.addTarget(self, action: #selector(withdrawButtonClicked), for: .touchUpInside)
        
    }
    
    @objc func toggleButtonClicked() {
        print("더 보기 버튼 눌림")
    }
    
    @objc func withdrawButtonClicked() {
        print("회원탈퇴 눌림")
    }
    
    func setupView() {
        view.addSubview(myInfoView)
        myInfoView.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
}

