//
//  NoneView.swift
//  SeSACFriends
//
//  Created by 신상원 on 2022/02/13.
//

import SnapKit
import UIKit

// MARK: 주변에 새싹이나 요청이 없는 경우의 View
class NoneView: UIView, ViewRepresentable {
    
    let sesacImage = UIImageView()
    let titleLabel = UILabel()
    let contentLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func setupView() {
        [sesacImage, titleLabel, contentLabel].forEach {
            self.addSubview($0)
        }
        sesacImage.image = UIImage(named: ImageSet.emptySesac)
        titleLabel.font = FontSet.displayR20
        titleLabel.textColor = UIColor(rgbString: ColorSet.black)
        titleLabel.textAlignment = .center
        
        contentLabel.font = FontSet.title4R14
        contentLabel.textColor = UIColor(rgbString: ColorSet.gray7)
        contentLabel.textAlignment = .center
    }
    
    func setupConstraints() {
        sesacImage.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(4)
            make.centerX.equalToSuperview()
            make.width.height.equalTo(64)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(sesacImage.snp.bottom).offset(32)
            make.leading.trailing.equalToSuperview()
        }
        
        contentLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
}
