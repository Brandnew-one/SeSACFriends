//
//  sesacNameView.swift
//  SeSACFriends
//
//  Created by 신상원 on 2022/02/03.
//

import SnapKit
import UIKit

class sesacNameView: UIView, ViewRepresentable {
    
    let nameLabel = UILabel()
    let toggleButton = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func setupView() {
        [nameLabel, toggleButton].forEach {
            self.addSubview($0)
        }
        
        nameLabel.textColor = UIColor(rgbString: ColorSet.black)
        nameLabel.font = FontSet.title1M16
        nameLabel.text = "신상원"
        
        toggleButton.setImage(UIImage(named: "more_arrow-bottom"), for: .normal)
        toggleButton.isEnabled = true
    }
    
    func setupConstraints() {
        nameLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.top.equalToSuperview().offset(16)
        }
        
        toggleButton.snp.makeConstraints { make in
            make.centerY.equalTo(nameLabel)
            make.trailing.equalToSuperview().offset(-16)
            make.width.equalTo(16)
            make.height.equalTo(16)
        }
    }
    
}
