//
//  ReportPopupView.swift
//  SeSACFriends
//
//  Created by 신상원 on 2022/02/19.
//

// MARK: 새싹신고, 리뷰등록 팝업뷰를 위한 팝업뷰
import SnapKit
import UIKit

class ReportPopupView: UIView, ViewRepresentable {
    
    var contentView = UIView()
    var titleLabel = UILabel()
    var closeButton = UIButton()
    var contentLabel = UILabel()
    
    // 좌 -> 우, 상 -> 하 순으로 설정
    var buttonView = UIView()
    var mybutton1 = MyButton(frame: CGRect(), mode: .inactive, text: "불법/사기")
    var mybutton2 = MyButton(frame: CGRect(), mode: .inactive, text: "불편한언행")
    var mybutton3 = MyButton(frame: CGRect(), mode: .inactive, text: "노쇼")
    var mybutton4 = MyButton(frame: CGRect(), mode: .inactive, text: "선정성")
    var mybutton5 = MyButton(frame: CGRect(), mode: .inactive, text: "인신공격")
    var mybutton6 = MyButton(frame: CGRect(), mode: .inactive, text: "기타")
    
    var textView = UITextView()
    var finalButton = MyButton(frame: CGRect(), mode: .disable, text: "신고하기")
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func setupView() {
        [contentView, buttonView, textView, finalButton].forEach {
            self.addSubview($0)
        }
        textView.backgroundColor = UIColor(rgbString: ColorSet.gray1)
        textView.font = FontSet.body3R14
        textView.clipsToBounds = true
        textView.layer.cornerRadius = 8
        
        [titleLabel, closeButton, contentLabel].forEach {
            contentView.addSubview($0)
        }
        titleLabel.font = FontSet.title3M14
        titleLabel.textColor = UIColor(rgbString: ColorSet.black)
        titleLabel.textAlignment = .center
        titleLabel.text = "새싹 신고"
        closeButton.setImage(UIImage(named: ImageSet.closeGray), for: .normal)
        contentLabel.font = FontSet.title4R14
        contentLabel.textColor = UIColor(rgbString: ColorSet.green)
        contentLabel.textAlignment = .center
        contentLabel.text = "다시는 해당 새싹과 매칭되지 않습니다"
        
        [mybutton1, mybutton2, mybutton3, mybutton4, mybutton5, mybutton6].forEach {
            buttonView.addSubview($0)
        }
    }
    
    func setupConstraints() {
        finalButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.trailing.bottom.equalToSuperview().offset(-16)
            make.height.equalTo(48)
        }
        
        textView.snp.makeConstraints { make in
            make.bottom.equalTo(finalButton.snp.top).offset(-24)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(124)
        }
        
        contentView.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(62)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(1)
            make.centerX.equalToSuperview()
        }
        
        closeButton.snp.makeConstraints { make in
            make.top.trailing.equalToSuperview()
            make.width.height.equalTo(24)
        }
        
        contentLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(17)
            make.centerX.bottom.equalToSuperview()
        }
        
        buttonView.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.bottom).offset(24)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(72)
        }
        
        mybutton1.snp.makeConstraints { make in
            make.top.leading.equalToSuperview()
            make.width.equalTo(98)
            make.height.equalTo(32)
        }
        
        mybutton3.snp.makeConstraints { make in
            make.top.trailing.equalToSuperview()
            make.width.equalTo(98)
            make.height.equalTo(32)
        }
        
        mybutton2.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalTo(mybutton1.snp.trailing).offset(8)
            make.trailing.equalTo(mybutton3.snp.leading).offset(-8)
            make.height.equalTo(32)
        }
        
        mybutton4.snp.makeConstraints { make in
            make.bottom.leading.equalToSuperview()
            make.width.equalTo(98)
            make.height.equalTo(32)
        }
        
        mybutton6.snp.makeConstraints { make in
            make.bottom.trailing.equalToSuperview()
            make.width.equalTo(98)
            make.height.equalTo(32)
        }
        
        mybutton5.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.leading.equalTo(mybutton4.snp.trailing).offset(8)
            make.trailing.equalTo(mybutton6.snp.leading).offset(-8)
            make.height.equalTo(32)
        }
    }
    
}
