//
//  GenderImageView.swift
//  SeSACFriends
//
//  Created by 신상원 on 2022/01/21.
//

import SnapKit
import UIKit

// 네이밍이 구리지만 imageview + label
class GenderImageView: UIView, ViewRepresentable {
    
    let imageView = UIImageView()
    let imageLable = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func setupView() {
        [imageView, imageLable].forEach {
            self.addSubview($0)
        }
        imageLable.font = FontSet.title2R16
        imageLable.textColor = UIColor(rgbString: ColorSet.black)
        imageLable.textAlignment = .center
    }
    
    func setupConstraints() {
        imageLable.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-14)
            //width 설정해야 할 수도 있음
        }
        
        imageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(imageLable.snp.top).offset(-2)
            make.width.height.equalTo(64)
        }
    }
    
    
    
}
