//
//  MyCardView.swift
//  SeSACFriends
//
//  Created by 신상원 on 2022/01/27.
//

import SnapKit
import UIKit

class MyCardView: UIView, ViewRepresentable {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func setupView() {
        <#code#>
    }
    
    func setupConstraints() {
        <#code#>
    }
    
}

class ToggleView: UIView, ViewRepresentable {
    
    let nameLabel = UILabel()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func setupView() {
        <#code#>
    }
    
    func setupConstraints() {
        <#code#>
    }
}
