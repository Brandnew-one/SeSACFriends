//
//  SesacTableViewCell.swift
//  SeSACFriends
//
//  Created by 신상원 on 2022/02/13.
//

import SnapKit
import UIKit

enum CellMode {
    case request
    case accept
}

class SesacTableViewCell: UITableViewCell, ViewRepresentable {

    static let identifier = "SesacTableViewCell"
    let cardView = MyCardView()
    let button = UIButton()
    var isTouched: Bool? {
        didSet {
            if isTouched == true {
                cardView.reviewView.isHidden = false
                cardView.titleView.isHidden = false
            } else {
                cardView.reviewView.isHidden = true
                cardView.titleView.isHidden = true
            }
        }
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    
    func setupView() {
        [cardView, button].forEach {
            contentView.addSubview($0)
        }
        
        button.clipsToBounds = true
        button.layer.cornerRadius = 8
        button.titleLabel?.font = FontSet.title3M14
        button.titleLabel?.textColor = UIColor(rgbString: ColorSet.white)
        button.backgroundColor = UIColor(rgbString: ColorSet.errorColor)
        button.setTitle("요청하기", for: .normal)

    }
    
    func setupConstraints() {
        cardView.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalToSuperview()
        }
        
        button.snp.makeConstraints { make in
            make.top.equalTo(cardView.backgroundImageView.snp.top).offset(12)
            make.trailing.equalTo(cardView.backgroundImageView.snp.trailing).offset(-12)
            make.width.equalTo(80)
            make.height.equalTo(40)
        }
    }
}
