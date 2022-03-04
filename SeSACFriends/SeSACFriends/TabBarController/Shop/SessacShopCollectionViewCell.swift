//
//  SessacShopCollectionViewCell.swift
//  SeSACFriends
//
//  Created by 신상원 on 2022/03/04.
//

import UIKit
import SnapKit

class SessacShopCollectionViewCell: UICollectionViewCell, ViewRepresentable {
    
    static let identifier = "SessacShopCollectionViewCell"
    
    let sesacImageView = UIImageView()
    let titleView = UIView()
    let titleLabel = UILabel()
    let contentLabel = UILabel()
    let priceButton = MyButton(frame: CGRect(), mode: .fill, text: "1,200")
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func setupView() {
        [sesacImageView, titleView].forEach {
            contentView.addSubview($0)
        }
        sesacImageView.clipsToBounds = true
        sesacImageView.layer.cornerRadius = 8
        sesacImageView.layer.borderWidth = 1
        sesacImageView.layer.borderColor = UIColor(rgbString: ColorSet.gray2).cgColor
        
        [titleLabel, contentLabel, priceButton].forEach {
            titleView.addSubview($0)
        }
        titleLabel.font = FontSet.title3M14
        titleLabel.textColor = UIColor(rgbString: ColorSet.black)
        
        contentLabel.font = FontSet.body3R14
        contentLabel.textColor = UIColor(rgbString: ColorSet.black)
        contentLabel.lineBreakMode = .byCharWrapping
        contentLabel.numberOfLines = 0
    }
    
    func setupConstraints() {
        sesacImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(19)
            make.leading.equalToSuperview().offset(13)
            make.trailing.equalToSuperview().offset(-6)
            make.height.equalTo(sesacImageView.snp.width)
        }
        
        titleView.snp.makeConstraints { make in
            make.top.equalTo(sesacImageView.snp.bottom)
            make.leading.equalToSuperview().offset(13)
            make.trailing.equalToSuperview().offset(-6)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.leading.equalToSuperview()
            make.trailing.equalTo(priceButton.snp.leading).offset(-1)
        }
        
        priceButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.trailing.equalToSuperview().offset(-9)
            make.height.equalTo(20)
            make.width.equalTo(52)
        }
        
        contentLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview()
        }
    }
    
}
