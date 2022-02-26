//
//  OnBoardingView.swift
//  SeSACFriends
//
//  Created by 신상원 on 2022/02/25.
//

import UIKit
import SnapKit

class OnBoardingView: UIView, ViewRepresentable {
    
    let label = UILabel()
    let imageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func setupView() {
        [label, imageView].forEach {
            self.addSubview($0)
        }
        label.font = FontSet.displayR24
        label.numberOfLines = 2
        label.textAlignment = .center
    }
    
    func setupConstraints() {
        label.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(60)
            make.trailing.equalToSuperview().offset(-60)
            make.top.equalToSuperview().offset(116)
        }
        
        imageView.snp.makeConstraints { make in
            make.top.equalTo(label.snp.bottom).offset(56)
            make.leading.equalToSuperview().offset(8)
            make.trailing.equalToSuperview().offset(-8)
            make.height.equalTo(imageView.snp.width)
        }
        
        
    }
    
}
