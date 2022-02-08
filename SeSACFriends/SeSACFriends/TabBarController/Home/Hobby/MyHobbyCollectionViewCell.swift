//
//  MyHobbyCollectionViewCell.swift
//  SeSACFriends
//
//  Created by 신상원 on 2022/02/08.
//

import SnapKit
import UIKit

class MyHobbyCollectionViewCell: UICollectionViewCell, ViewRepresentable {
  
    static let identifier = "MyHobbyCollectionViewCell"
    
    let cellLabel = UILabel()
    let cellImage = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func setupView() {
        [cellLabel, cellImage].forEach {
            self.addSubview($0)
        }
        self.clipsToBounds = true
        self.layer.cornerRadius = 8
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor(rgbString: ColorSet.green).cgColor
        
        cellLabel.font = FontSet.title4R14
        cellLabel.textColor = UIColor(rgbString: ColorSet.green)
        
        cellImage.image = UIImage(named: ImageSet.closeGreen)
    }
    
    func setupConstraints() {
        cellLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-36)
            make.top.equalToSuperview().offset(5)
            make.bottom.equalToSuperview().offset(-5)
        }
        
        cellImage.snp.makeConstraints { make in
            make.leading.equalTo(cellLabel.snp.trailing).offset(4)
            make.centerY.equalTo(cellLabel)
            make.height.width.equalTo(16)
        }
    }
    
    
}
