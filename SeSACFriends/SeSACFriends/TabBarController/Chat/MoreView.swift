//
//  MoreView.swift
//  SeSACFriends
//
//  Created by 신상원 on 2022/02/19.
//

import SnapKit
import UIKit

// MARK: Button + Label 을 View 로 묶어주는 View
class MoreButtonView: UIView, ViewRepresentable {
    
    let button = UIButton()
    let buttonLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func setupView() {
        [button, buttonLabel].forEach {
            self.addSubview($0)
        }
        buttonLabel.font = FontSet.title3M14
        buttonLabel.textColor = UIColor(rgbString: ColorSet.black)
        buttonLabel.textAlignment = .center
    }
    
    func setupConstraints() {
        button.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(11)
            make.centerX.equalToSuperview()
            make.height.width.equalTo(24)
        }
        buttonLabel.snp.makeConstraints { make in
            make.top.equalTo(button.snp.bottom).offset(8)
            make.centerX.equalToSuperview()
        }
    }
}

// MARK: ButtonView 3개를 스택뷰에 넣어주는 형태
class MoreView: UIView, ViewRepresentable {
    
    let navigationView = UIView()
    let backButton = UIButton()
    let moretButton = UIButton()
    let userLabel = UILabel()
    
    let stackView = UIStackView()
    let reportButtonView = MoreButtonView()
    let cancleButtonView = MoreButtonView()
    let reviewButtonView = MoreButtonView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func setupView() {
        [navigationView, stackView].forEach {
            self.addSubview($0)
        }
        navigationView.backgroundColor = .white
        stackView.backgroundColor = .white
        
        [backButton, userLabel, moretButton].forEach {
            navigationView.addSubview($0)
        }
        
        backButton.setImage(UIImage(named: ImageSet.backButton), for: .normal)
        moretButton.setImage(UIImage(named: ImageSet.more), for: .normal)
        userLabel.font = FontSet.title3M14
        userLabel.textColor = UIColor(rgbString: ColorSet.black)
        userLabel.textAlignment = .center
        
        stackView.backgroundColor = .white
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 0
        
        [reportButtonView, cancleButtonView, reviewButtonView].forEach {
            stackView.addArrangedSubview($0)
        }
        reportButtonView.button.setImage(UIImage(named: ImageSet.siren), for: .normal)
        reportButtonView.buttonLabel.text = "새싹 신고"
        cancleButtonView.button.setImage(UIImage(named: ImageSet.matchCancle), for: .normal)
        cancleButtonView.buttonLabel.text = "약속 취소"
        reviewButtonView.button.setImage(UIImage(named: ImageSet.write), for: .normal)
        reviewButtonView.buttonLabel.text = "리뷰 등록"
    }
    
    func setupConstraints() {
        navigationView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(44)
        }
        
        backButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.leading.equalToSuperview().offset(16)
            make.bottom.equalToSuperview().offset(-10)
            make.width.height.equalTo(24)
        }
        
        moretButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-10)
            make.bottom.equalToSuperview().offset(-10)
            make.width.height.equalTo(24)
        }
        
        userLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.centerX.equalToSuperview()
        }
        
        stackView.snp.makeConstraints { make in
            make.top.equalTo(navigationView.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
    
}
