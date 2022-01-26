//
//  InformationTableViewCell.swift
//  SeSACFriends
//
//  Created by 신상원 on 2022/01/26.
//

import SnapKit
import UIKit

class InformationTableViewCell: UITableViewCell, ViewRepresentable {
    
    static let identifier = "informationTableViewCell"
    let imagesView = UIImageView()
    let titleLabel = UILabel()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func setupView() {
        [imagesView, titleLabel].forEach {
            self.addSubview($0)
        }
        titleLabel.textColor = UIColor(rgbString: ColorSet.black)
        titleLabel.font = FontSet.title2R16
    }
    
    func setupConstraints() {
        imagesView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(19)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(20)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(imagesView.snp.trailing).offset(14)
            make.centerY.equalToSuperview()
            make.trailing.greaterThanOrEqualToSuperview().offset(-14)
        }
    }
    
}
