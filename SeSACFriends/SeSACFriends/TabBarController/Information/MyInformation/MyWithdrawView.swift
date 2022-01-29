//
//  MyWithdrawView.swift
//  SeSACFriends
//
//  Created by 신상원 on 2022/01/27.
//

import SnapKit
import UIKit

class MyWithdrawView: UIView, ViewRepresentable {
    
    let button = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func setupView() {
        self.addSubview(button)
        button.setTitle("회원탈퇴", for: .normal)
        button.titleLabel?.font = FontSet.title4R14
        button.setTitleColor(UIColor(rgbString: ColorSet.black), for: .normal)
    }
    
    func setupConstraints() {
        button.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.top.equalToSuperview().offset(13)
            make.bottom.equalToSuperview().offset(-13)
        }
    }
}
