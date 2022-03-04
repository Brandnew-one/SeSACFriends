//
//  BackgroundTableViewCell.swift
//  SeSACFriends
//
//  Created by 신상원 on 2022/03/04.
//

import UIKit
import SnapKit

class BackgroundTableViewCell: UITableViewCell, ViewRepresentable {
    
    static let identifier = "BackgroundTableViewCell"
    let backgroundImageView = UIImageView()
    let titleView = UIView()
    let titleLabel = UILabel()
    let contentLabel = UILabel()
    let priceButton = MyButton(frame: CGRect(), mode: .fill, text: "1,200")
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func setupView() {
        [backgroundImageView, titleView].forEach {
            contentView.addSubview($0)
        }
        
        [titleLabel, contentLabel, priceButton].forEach {
            titleView.addSubview($0)
        }
        titleView.backgroundColor = .white
        backgroundImageView.clipsToBounds = true
        backgroundImageView.layer.cornerRadius = 8
        
        titleLabel.font = FontSet.title3M14
        titleLabel.textColor = UIColor(rgbString: ColorSet.black)
        
        contentLabel.font = FontSet.body3R14
        contentLabel.textColor = UIColor(rgbString: ColorSet.black)
        contentLabel.lineBreakMode = .byCharWrapping
        contentLabel.numberOfLines = 0
    }
    
    func setupConstraints() {
        backgroundImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(4)
            make.leading.equalToSuperview().offset(16)
            make.width.equalTo(titleView.snp.width)
            make.height.equalTo(titleView.snp.width)
        }
        
        titleView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(4)
            make.leading.equalTo(backgroundImageView.snp.trailing).offset(12)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(titleView.snp.width)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(43)
            make.leading.equalToSuperview()
            make.trailing.equalTo(priceButton.snp.leading).offset(-8)
        }
        
        priceButton.snp.makeConstraints { make in
            make.top.equalTo(titleLabel)
            make.trailing.equalToSuperview()
            make.width.equalTo(52)
            make.height.equalTo(20)
        }
        
        contentLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
        }
        
    }
}
