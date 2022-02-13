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
//    var mode: CellMode
//
//    init(style: UITableViewCell.CellStyle, reuseIdentifier: String?, mode: CellMode) {
//        self.mode = mode
//        super.init(style: style, reuseIdentifier: reuseIdentifier)
//        setupView()
//        setupConstraints()
//    }
    
//    override func layoutSubviews() {
//        super.layoutSubviews()
//        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0))
//    }
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
        setupConstraints()
//        layoutSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    
    func setupView() {
        [cardView, button].forEach {
            self.addSubview($0)
        }
        
        button.clipsToBounds = true
        button.layer.cornerRadius = 8
        button.titleLabel?.font = FontSet.title3M14
        button.titleLabel?.textColor = UIColor(rgbString: ColorSet.white)
        button.backgroundColor = UIColor(rgbString: ColorSet.errorColor)
        button.setTitle("요청하기", for: .normal)

    }
    
//    func setupMode() {
//        if mode == .accept {
//            button.backgroundColor = UIColor(rgbString: ColorSet.successColor)
//            button.setTitle("수락하기", for: .normal)
//        } else {
//            button.backgroundColor = UIColor(rgbString: ColorSet.errorColor)
//            button.setTitle("요청하기", for: .normal)
//        }
//    }
    
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
