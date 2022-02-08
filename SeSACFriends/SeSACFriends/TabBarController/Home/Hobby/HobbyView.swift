//
//  HobbyView.swift
//  SeSACFriends
//
//  Created by 신상원 on 2022/02/08.
//

import SnapKit
import UIKit

class HobbyView: UIView, ViewRepresentable {
    
    let findButton = MyButton(frame: CGRect(), mode: .fill, text: "새싹 찾기")
   
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func setupView() {
        print(#function)
    }
    
    func setupConstraints() {
        print(#function)
    }
    
}
