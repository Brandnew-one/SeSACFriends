//
//  ShopImageView.swift
//  SeSACFriends
//
//  Created by 신상원 on 2022/03/03.
//

import UIKit
import SnapKit

class ShopImageView: UIView, ViewRepresentable {
    
    let backgroundImageView = UIImageView()
    let sesacImageView = UIImageView()
    let button = MyButton(frame: CGRect(), mode: .fill, text: "저장하기")
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func setupView() {
        [backgroundImageView, sesacImageView, button].forEach {
            self.addSubview($0)
        }
        backgroundImageView.clipsToBounds = true
        backgroundImageView.layer.cornerRadius = 8
        //Test Default
        backgroundImageView.image = UIImage(named: ImageSet.background1)
        sesacImageView.image = UIImage(named: ImageSet.face1)
    }
    
    func setupConstraints() {
        backgroundImageView.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalToSuperview()
        }
        
        sesacImageView.snp.makeConstraints { make in
            make.top.equalTo(backgroundImageView).offset(11)
            make.leading.equalTo(backgroundImageView).offset(77)
            make.trailing.equalTo(backgroundImageView).offset(-87.2)
            make.bottom.equalTo(backgroundImageView).offset(20.39)
        }
        
        button.snp.makeConstraints { make in
            make.top.equalTo(backgroundImageView).offset(13)
            make.trailing.equalTo(backgroundImageView).offset(-15)
            make.width.equalTo(80)
            make.height.equalTo(40)
        }
    }
    
}
