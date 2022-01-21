//
//  EmailView.swift
//  SeSACFriends
//
//  Created by 신상원 on 2022/01/21.
//

import SnapKit

import UIKit

class EmailView: UIView, ViewRepresentable {
    
    let loginView = LoginView()
    let subLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func setupView() {
        [loginView, subLabel].forEach {
            self.addSubview($0)
        }
        subLabel.font = FontSet.title2R16
        subLabel.textColor = UIColor(rgbString: ColorSet.gray7)
        subLabel.textAlignment = .center
    }
    
    func setupConstraints() {
        loginView.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalToSuperview()
        }
        
        subLabel.snp.makeConstraints { make in
            make.top.equalTo(loginView.textLabel.snp.bottom).offset(8)
            make.trailing.equalToSuperview().offset(-40)
            make.leading.equalToSuperview().offset(40)
        }
    }
}
