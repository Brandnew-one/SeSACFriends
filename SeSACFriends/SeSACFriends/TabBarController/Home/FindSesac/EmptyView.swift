//
//  EmptyView.swift
//  SeSACFriends
//
//  Created by 신상원 on 2022/02/15.
//

//MARK: noneView + 버튼을 합쳐서 뷰로 만들어 주기 위해서
import SnapKit
import UIKit

class EmptyView: UIView, ViewRepresentable {

    let noneView = NoneView()
    let myButton = MyButton(frame: CGRect(), mode: .fill, text: "취미 변경하기")
    let refreshButton = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func setupView() {
        [noneView, myButton, refreshButton].forEach {
            self.addSubview($0)
        }
        noneView.titleLabel.text = "아쉽게도 주변에 새싹이 없어요ㅠ"
        noneView.contentLabel.text = "취미를 변경하거나 조금만 더 기다려 주세요!"
        
        refreshButton.clipsToBounds = true
        refreshButton.layer.cornerRadius = 8
        refreshButton.layer.borderColor = UIColor(rgbString: ColorSet.green).cgColor
        refreshButton.layer.borderWidth = 1
        refreshButton.setImage(UIImage(named: ImageSet.refresh), for: .normal)
    }
    
    func setupConstraints() {
        noneView.snp.makeConstraints { make in
            make.centerY.equalToSuperview().offset(-24)
//            make.centerX.equalToSuperview()
            make.leading.trailing.equalToSuperview()
//            make.leading.equalToSuperview().offset(46)
//            make.trailing.equalToSuperview().offset(-46)
            make.height.equalTo(158)
        }
        refreshButton.snp.makeConstraints { make in
            make.trailing.bottom.equalToSuperview()
            make.height.width.equalTo(48)
        }
        myButton.snp.makeConstraints { make in
            make.leading.bottom.equalToSuperview()
            make.trailing.equalTo(refreshButton.snp.leading).offset(-8)
            make.height.equalTo(48)
        }
    }
    
    
}
