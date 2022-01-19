//
//  CustomTextField.swift
//  SeSACFriends
//
//  Created by 신상원 on 2022/01/18.
//

import SnapKit
import UIKit

enum TextFieldMode: Int {
    case inactive
    case focus
    case active
    case disable
    case error
    case success
}

class CustomTextField: UIView, ViewRepresentable {
    
    let contentsView = UIView()
    let textField = UITextField()
    let lineView = UIView()
    let additionLabel = UILabel()
    var mode: TextFieldMode
    
    
    init(frame: CGRect, mode: TextFieldMode) {
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
        [contentsView, additionLabel].forEach {
            self.addSubview($0)
        }
        [textField, lineView].forEach {
            contentsView.addSubview($0)
        }
        
        contentsView.clipsToBounds = true
        contentsView.layer.cornerRadius = 4
        
        textField.backgroundColor = .clear
        textField.font = FontSet.title4R14
        textField.placeholder = "내용을 입력"
        
        additionLabel.isHidden = true
        additionLabel.font = FontSet.body4R12
    }
    
    func setupConstraints() {
        contentsView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(48)
        }
        
        textField.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(13)
            make.leading.equalToSuperview().offset(12)
            make.trailing.equalToSuperview().offset(-12)
            make.bottom.equalToSuperview().offset(-13)
        }
        
        lineView.snp.makeConstraints { make in
            make.top.equalTo(textField.snp.bottom).offset(12)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(1)
        }
        
        additionLabel.snp.makeConstraints { make in
            make.top.equalTo(lineView.snp.bottom).offset(4)
            make.leading.equalToSuperview().offset(12)
            make.trailing.equalToSuperview().offset(-12)
            make.bottom.equalToSuperview().offset(-4)
        }
    }
    
    func setupMode(mode: TextFieldMode) {
        self.mode = mode
        additionLabel.isHidden = true
        
        switch self.mode {
        case .inactive:
            textField.textColor = UIColor(rgbString: ColorSet.gray7)
            lineView.backgroundColor = UIColor(rgbString: ColorSet.gray3)
        case .focus:
            textField.textColor = UIColor(rgbString: ColorSet.black)
            lineView.backgroundColor = UIColor(rgbString: ColorSet.black)
        case .active:
            textField.textColor = UIColor(rgbString: ColorSet.black)
            lineView.backgroundColor = UIColor(rgbString: ColorSet.gray3)
        case .disable:
            contentsView.backgroundColor = UIColor(rgbString: ColorSet.gray3)
            textField.textColor = UIColor(rgbString: ColorSet.gray7)
            lineView.backgroundColor = .clear
        case .success:
            textField.textColor = UIColor(rgbString: ColorSet.black)
            lineView.backgroundColor = UIColor(rgbString: ColorSet.successColor)
            additionLabel.textColor = UIColor(rgbString: ColorSet.successColor)
            additionLabel.isHidden = false
        case .error:
            textField.textColor = UIColor(rgbString: ColorSet.black)
            lineView.backgroundColor = UIColor(rgbString: ColorSet.errorColor)
            additionLabel.textColor = UIColor(rgbString: ColorSet.errorColor)
            additionLabel.isHidden = false
        }
    }
    
}
