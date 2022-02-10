//
//  MyHobbyCollectionViewCell.swift
//  SeSACFriends
//
//  Created by 신상원 on 2022/02/08.
//

import SnapKit
import UIKit

//MARK: 내가 선택한 취미
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

//MARK: 서버에서 추천하는 취미
class ServerHobbyCollectionViewCell: UICollectionViewCell, ViewRepresentable {
  
    static let identifier = "ServerHobbyCollectionViewCell"
    
    let cellLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func setupView() {
        [cellLabel].forEach {
            self.addSubview($0)
        }
        self.clipsToBounds = true
        self.layer.cornerRadius = 8
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor(rgbString: ColorSet.errorColor).cgColor
        
        cellLabel.font = FontSet.title4R14
        cellLabel.textColor = UIColor(rgbString: ColorSet.errorColor)
        
    }
    
    func setupConstraints() {
        cellLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.top.equalToSuperview().offset(5)
            make.bottom.equalToSuperview().offset(-5)
        }
    }
    
    
}

//MARK: 지금 주변 취미
class OtherHobbyCollectionViewCell: UICollectionViewCell, ViewRepresentable {
  
    static let identifier = "OtherHobbyCollectionViewCell"
    
    let cellLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func setupView() {
        [cellLabel].forEach {
            self.addSubview($0)
        }
        self.clipsToBounds = true
        self.layer.cornerRadius = 8
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor(rgbString: ColorSet.gray4).cgColor
        
        cellLabel.font = FontSet.title4R14
        cellLabel.textColor = UIColor(rgbString: ColorSet.black)
        
    }
    
    func setupConstraints() {
        cellLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.top.equalToSuperview().offset(5)
            make.bottom.equalToSuperview().offset(-5)
        }
    }
    
}
