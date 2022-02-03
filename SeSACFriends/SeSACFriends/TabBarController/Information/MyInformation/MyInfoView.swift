//
//  MyInfoView.swift
//  SeSACFriends
//
//  Created by 신상원 on 2022/01/26.
//

import SnapKit
import UIKit

class MyInfoView: UIView, ViewRepresentable {
    
    let scrollView = UIScrollView()
    let containerView = UIView()
    let myCardView = MyCardView()
    let myGenderView = MyGenderView()
    let myHobbyView = MyHobbyView()
    let myPhoneView = MyPhoneView()
    let myAgeView = MyAgeView()
    let myWithdrawView = MyWithdrawView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func setupView() {
        addSubview(scrollView)
        scrollView.addSubview(containerView)
        [myGenderView, myHobbyView, myPhoneView, myAgeView, myWithdrawView, myCardView].forEach {
            containerView.addSubview($0)
        }
    }
    
    func setupConstraints() {
        
        scrollView.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalToSuperview()
        }
        
        containerView.snp.makeConstraints { make in
            make.top.bottom.leading.trailing.equalTo(scrollView.contentLayoutGuide)
            make.width.equalTo(scrollView.frameLayoutGuide)
        }
        
        myCardView.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.top.equalToSuperview().offset(16)
        }
        
        myGenderView.snp.makeConstraints { make in
            make.top.equalTo(myCardView.toggleView.snp.bottom).offset(24)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
//            make.leading.trailing.equalToSuperview()
            make.height.equalTo(48)
        }
        
        myHobbyView.snp.makeConstraints { make in
            make.top.equalTo(myGenderView.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
//            make.leading.trailing.equalToSuperview()
            make.height.equalTo(48)
        }
        
        myPhoneView.snp.makeConstraints { make in
            make.top.equalTo(myHobbyView.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
//            make.leading.trailing.equalToSuperview()
            make.height.equalTo(48)
        }
        
        myAgeView.snp.makeConstraints { make in
            make.top.equalTo(myPhoneView.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
//            make.leading.trailing.equalToSuperview()
            make.height.equalTo(80)
        }
        
        myWithdrawView.snp.makeConstraints { make in
            make.top.equalTo(myAgeView.ageSlider.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(16)
            make.trailing.bottom.equalToSuperview().offset(-16)
//            make.leading.trailing.equalToSuperview()
            make.height.equalTo(48)
        }
        
    }
    
}
