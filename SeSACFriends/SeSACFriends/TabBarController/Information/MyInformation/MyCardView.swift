//
//  MyCardView.swift
//  SeSACFriends
//
//  Created by 신상원 on 2022/01/27.
//

import SnapKit
import UIKit

class MyCardView: UIView, ViewRepresentable {
    
    let backgroundImageView = UIImageView()
    let sesacImageView = UIImageView()
    
    let stackView = UIStackView()
    let nameView = sesacNameView()
    let titleView = sesacTitleView()
    let reviewView = sesacReviewView(frame: CGRect(), review: nil)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func setupView() {
        [backgroundImageView, sesacImageView, stackView].forEach {
            self.addSubview($0)
        }
        backgroundImageView.image = UIImage(named: "sesac_bg_01")
        backgroundImageView.clipsToBounds = true
        backgroundImageView.layer.cornerRadius = 8
        sesacImageView.image = UIImage(named: "sesac_face_2")
        
        
        stackView.backgroundColor = .white
        stackView.axis = .vertical
        stackView.distribution = .fill
        
        stackView.layer.cornerRadius = 8
        stackView.layer.borderColor = UIColor(rgbString: ColorSet.gray2).cgColor
        stackView.layer.borderWidth = 1
        stackView.spacing = 16.0
        
        [nameView, titleView, reviewView].forEach {
            stackView.addArrangedSubview($0)
        }
        
        reviewView.setupMode(review: "한줄이 길면 제대로 나오나?\n나와라 이놈아")
    }
    
    func setupConstraints() {
        backgroundImageView.snp.makeConstraints { make in
            make.top.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.equalTo(194)
        }
        
        sesacImageView.snp.makeConstraints { make in
            make.top.equalTo(backgroundImageView).offset(19)
            make.leading.equalTo(backgroundImageView).offset(75)
            make.trailing.equalTo(backgroundImageView).offset(-84)
            make.height.equalTo(184)
        }
        
        stackView.snp.makeConstraints { make in
            make.top.equalTo(backgroundImageView.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
        }

        nameView.snp.makeConstraints { make in
            make.height.equalTo(58)
        }
        
        titleView.snp.makeConstraints { make in
            make.height.equalTo(146)
        }
        
    }
    
}

//class ToggleView: UIView, ViewRepresentable {
//
//    let stackView = UIStackView()
//    let nameView = sesacNameView()
//    let titleView = sesacTitleView()
//    let reviewView = sesacReviewView(frame: CGRect(), review: nil)
//
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        setupView()
//        setupConstraints()
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError()
//    }
//
//    func setupView() {
//        self.addSubview(stackView)
//        stackView.backgroundColor = .white
//        stackView.axis = .vertical
////        stackView.distribution = .fill
//
//        stackView.layer.cornerRadius = 8
//        stackView.layer.borderColor = UIColor(rgbString: ColorSet.gray2).cgColor
//        stackView.layer.borderWidth = 1
//        stackView.spacing = 16.0
//
//        [nameView, titleView, reviewView].forEach {
//            stackView.addArrangedSubview($0)
//        }
//        stackView.backgroundColor = .systemPink
//        nameView.backgroundColor = .systemGray2
//        titleView.backgroundColor = .systemGray4
//        reviewView.backgroundColor = .systemGray6
//    }
//
//    func setupConstraints() {
//
//        stackView.snp.makeConstraints { make in
//            make.top.leading.trailing.bottom.equalToSuperview()
//        }
//
//        nameView.snp.makeConstraints { make in
////            make.leading.equalTo(stackView.snp.leading).offset(16)
////            make.trailing.equalTo(stackView.snp.trailing).offset(-16)
//            make.height.equalTo(58)
//        }
//
//        titleView.snp.makeConstraints { make in
//            make.leading.equalTo(stackView.snp.leading).offset(16)
//            make.trailing.equalTo(stackView.snp.trailing).offset(-16)
//            make.height.equalTo(146)
//        }
//
//        reviewView.snp.makeConstraints { make in
//            make.leading.equalTo(stackView.snp.leading).offset(16)
//            make.trailing.equalTo(stackView.snp.trailing).offset(-16)
//            make.bottom.equalTo(stackView.snp.bottom).offset(-16)
//        }
//    }
//}
