//
//  InformationHeaderView.swift
//  SeSACFriends
//
//  Created by 신상원 on 2022/01/26.
//

import SnapKit
import UIKit

class InformationHeaderViewCell: UITableViewCell, ViewRepresentable {
    
    static let identifier = "InformationHeaderViewCell"
    
    let leftImageView = UIImageView()
    let titleLable = UILabel()
    let rightImageView = UIImageView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func setupView() {
        [leftImageView, titleLable, rightImageView].forEach {
            self.addSubview($0)
        }
        leftImageView.clipsToBounds = true
        leftImageView.layer.cornerRadius = 24
        leftImageView.layer.borderWidth = 1
        leftImageView.layer.borderColor = UIColor.init(rgbString: ColorSet.gray2).cgColor
        leftImageView.image = UIImage(named: "sesac_face_1 1")
        
        rightImageView.image = UIImage(named: "more_arrow")
        
        titleLable.textColor = UIColor.init(rgbString: ColorSet.black)
        titleLable.font = FontSet.title1M16
    }
    
    func setupConstraints() {
        leftImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(24)
            make.leading.equalToSuperview().offset(17)
            make.height.width.equalTo(48)
        }
        
        titleLable.snp.makeConstraints { make in
            make.leading.equalTo(leftImageView.snp.trailing).offset(13)
            make.centerY.equalTo(leftImageView)
        }
        
        rightImageView.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-22.5)
            make.centerY.equalTo(leftImageView)
            make.height.equalTo(18)
            make.width.equalTo(9)
        }
    }
    
}
