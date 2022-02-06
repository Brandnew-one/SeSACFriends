//
//  StatusButton.swift
//  SeSACFriends
//
//  Created by 신상원 on 2022/02/06.
//

import SnapKit
import UIKit

enum StatusButtonMode {
    case search
    case antenna
    case message
}

class StatusButtonView: UIView, ViewRepresentable {
    
    var mode: StatusButtonMode
    var button = UIButton()
    
    init(frame: CGRect, mode: StatusButtonMode) {
        self.mode = mode
        super.init(frame: frame)
        setupView()
        setupConstraints()
        setupMode(mode: mode)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func setupView() {
        self.addSubview(button)
        self.backgroundColor = UIColor(rgbString: ColorSet.black)
        self.clipsToBounds = true
        self.layer.cornerRadius = 32
    }
    
    func setupConstraints() {
        button.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().offset(12)
            make.trailing.bottom.equalToSuperview().offset(-12)
        }
    }
    
    func setupMode(mode: StatusButtonMode) {
        switch mode {
        case .search:
            button.setImage(UIImage(named: ImageSet.search), for: .normal)
        case .antenna:
            button.setImage(UIImage(named: ImageSet.antenna), for: .normal)
        case .message:
            button.setImage(UIImage(named: ImageSet.message), for: .normal)
        }
    }
    
}
