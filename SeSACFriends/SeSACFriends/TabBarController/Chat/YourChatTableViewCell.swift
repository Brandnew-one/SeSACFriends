//
//  YourChatTableViewCell.swift
//  SeSACFriends
//
//  Created by 신상원 on 2022/02/21.
//

import SnapKit
import UIKit

class YourChatTableViewCell: UITableViewCell, ViewRepresentable {
    
    static let identifier = "YourChatTableViewCell"
    
    let chatView = UIView()
    let label = UILabel()
    let timeLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func setupView() {
        [chatView, timeLabel].forEach {
            self.addSubview($0)
        }
        chatView.addSubview(label)
        chatView.clipsToBounds = true
        chatView.layer.cornerRadius = 8
        chatView.backgroundColor = UIColor(rgbString: ColorSet.whiteGreen)
        
        timeLabel.font = FontSet.title6R12
        timeLabel.textColor = UIColor(rgbString: ColorSet.gray6)
        label.font = FontSet.body3R14
        label.textColor = UIColor(rgbString: ColorSet.black)
        label.numberOfLines = 0
    }
    
    func setupConstraints() {
        chatView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.trailing.equalToSuperview().offset(-16)
            make.leading.greaterThanOrEqualToSuperview().offset(95)
        }
        
        label.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.bottom.equalToSuperview().offset(-10)
        }
        
        timeLabel.snp.makeConstraints { make in
            make.bottom.equalTo(chatView.snp.bottom)
            make.trailing.equalTo(chatView.snp.leading).offset(-8)
        }
    }

    
}
