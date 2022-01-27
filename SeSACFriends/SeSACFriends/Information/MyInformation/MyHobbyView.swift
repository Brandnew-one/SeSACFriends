//
//  MyHobbyView.swift
//  SeSACFriends
//
//  Created by 신상원 on 2022/01/26.
//

import SnapKit
import UIKit

class MyHobbyView: UIView, ViewRepresentable {
    
    let label = UILabel()
    let textField = CustomTextField(frame: CGRect(), mode: .inactive)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func setupView() {
        [label, textField].forEach {
            self.addSubview($0)
        }
        label.textColor = UIColor(rgbString: ColorSet.black)
        label.font = FontSet.title4R14
    }
    
    func setupConstraints() {
        label.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.top.equalToSuperview().offset(13)
            make.bottom.equalToSuperview().offset(-13)
        }
        
        textField.snp.makeConstraints { make in
            make.top.bottom.trailing.equalToSuperview()
            make.width.equalTo(164)
        }
    }
}
