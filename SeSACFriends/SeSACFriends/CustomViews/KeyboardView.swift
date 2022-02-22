//
//  KeyboardView.swift
//  SeSACFriends
//
//  Created by 신상원 on 2022/02/22.
//

import SnapKit
import UIKit

class KeyboardView: UIView, ViewRepresentable {
    
    let contentView = UIView()
    var textView = UITextView()
    var sendButton = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func setupView() {
        self.addSubview(contentView)
        contentView.backgroundColor = UIColor(rgbString: ColorSet.gray1)
        contentView.clipsToBounds = true
        contentView.layer.cornerRadius = 8
        
        [textView, sendButton].forEach {
            contentView.addSubview($0)
        }
        textView.backgroundColor = UIColor(rgbString: ColorSet.gray1)
        textView.font = FontSet.body3R14
        sendButton.setImage(UIImage(named: ImageSet.send), for: .normal)
    }
    
    func setupConstraints() {
        contentView.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalToSuperview()
        }
        
        textView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(14)
            make.leading.equalToSuperview().offset(12)
            make.trailing.equalToSuperview().offset(-44)
            make.bottom.equalToSuperview().offset(-14)
        }
        
        sendButton.snp.makeConstraints { make in
            make.leading.equalTo(textView.snp.trailing).offset(10)
            make.centerY.equalTo(textView)
            make.width.height.equalTo(24)
        }
    }
    
}
