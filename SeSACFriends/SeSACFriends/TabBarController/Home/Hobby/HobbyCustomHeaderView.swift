//
//  HobbyCustomHeaderView.swift
//  SeSACFriends
//
//  Created by 신상원 on 2022/02/08.
//

import SnapKit
import UIKit

class HobbyCustomHeaderView: UICollectionReusableView, ViewRepresentable {
    
    static let identifier = "HobbyCustomHeaderView"
    let headerLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func setupView() {
        self.addSubview(headerLabel)
        headerLabel.font = FontSet.title6R12
        headerLabel.textColor = .black
    }
    
    func setupConstraints() {
        headerLabel.snp.makeConstraints { make in
            make.top.leading.equalToSuperview()
        }
    }
    
    
}
