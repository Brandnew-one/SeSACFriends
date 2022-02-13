//
//  RequestViewController.swift
//  SeSACFriends
//
//  Created by 신상원 on 2022/02/13.
//

import SnapKit
import UIKit

class RequestViewController: UIViewController, ViewRepresentable {
    
    let noneView = NoneView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupConstraints()
    }
    
    func setupView() {
        view.backgroundColor = .white
        view.addSubview(noneView)
        noneView.titleLabel.text = "아직 받은 요청이 없어요ㅠ"
        noneView.contentLabel.text = "취미를 변경하거나 조금만 더 기다려 주세요!"
    }
    
    func setupConstraints() {
        noneView.snp.makeConstraints { make in
//            make.centerX.equalToSuperview()
            make.centerY.equalTo(view.safeAreaLayoutGuide).offset(-24)
            make.leading.equalToSuperview().offset(56)
            make.trailing.equalToSuperview().offset(-56)
            make.height.equalTo(158)
        }
    }
    
}
