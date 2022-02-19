//
//  PopupView.swift
//  SeSACFriends
//
//  Created by 신상원 on 2022/02/14.
//

import SnapKit
import UIKit

//MARK: Basic 한 popup
class PopupView: UIView, ViewRepresentable {
    
    var contentView = UIView()
    var titleLabel = UILabel()
    var contentLabel = UILabel()
    var okButtoon = MyButton(frame: CGRect(), mode: .fill, text: "확인")
    var cancleButton = MyButton(frame: CGRect(), mode: .cancel, text: "취소")
    
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
        contentView.backgroundColor = UIColor(rgbString: ColorSet.white)
        contentView.clipsToBounds = true
        contentView.layer.cornerRadius = 16
        
        [titleLabel, contentLabel, okButtoon, cancleButton].forEach {
            contentView.addSubview($0)
        }
        
        titleLabel.textColor = UIColor(rgbString: ColorSet.black)
        titleLabel.textAlignment = .center
        titleLabel.font = FontSet.body1M16
        titleLabel.text = "정말 탈퇴하시겠습니까?"
        
        contentLabel.textColor = UIColor(rgbString: ColorSet.black)
        contentLabel.textAlignment = .center
        contentLabel.font = FontSet.title4R14
        contentLabel.text = "탈퇴하시면 새싹 프렌즈를 이용할 수 없어요ㅠ"
    }
    
    func setupConstraints() {
        contentView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.centerY.equalToSuperview()
            make.height.equalTo(156)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
        
        contentLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
        
        cancleButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.bottom.equalToSuperview().offset(-16)
            make.trailing.equalTo(okButtoon.snp.leading).offset(-8)
            make.width.equalTo(okButtoon)
            make.height.equalTo(48)
        }
        
        okButtoon.snp.makeConstraints { make in
            make.bottom.trailing.equalToSuperview().offset(-16)
            make.width.equalTo(cancleButton)
            make.height.equalTo(48)
        }
    }
    
    
}
