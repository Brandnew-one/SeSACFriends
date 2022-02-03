//
//  sesacReviewTableViewCell.swift
//  SeSACFriends
//
//  Created by 신상원 on 2022/02/01.
//

import SnapKit
import UIKit

class sesacReviewView: UIView, ViewRepresentable {
    
    let titleLabel = UILabel()
    let contentLabel = UILabel()
    var review: String?
    
    
    init(frame: CGRect, review: String?) {
        self.review = review
        super.init(frame: frame)
        setupView()
        setupConstraints()
        setupMode(review: self.review)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func setupView() {
        [titleLabel, contentLabel].forEach {
            self.addSubview($0)
        }
        
        titleLabel.font = FontSet.title6R12
        titleLabel.textColor = UIColor(rgbString: ColorSet.black)
        titleLabel.text = "새싹 리뷰"
        
        contentLabel.font = FontSet.body3R14
        contentLabel.textColor = UIColor(rgbString: ColorSet.gray6)
    }
    
    func setupConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.leading.equalToSuperview()
        }
        
        contentLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(16)
            make.leading.bottom.equalToSuperview()
        }
    }
    
    func setupMode(review: String?) {
        if let review = review {
            contentLabel.text = review
        } else {
            contentLabel.text = "첫 리뷰를 기다리는 중이에요!"
        }
    }
    
    
}
