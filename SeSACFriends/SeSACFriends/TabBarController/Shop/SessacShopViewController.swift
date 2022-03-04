//
//  SessacShopViewController.swift
//  SeSACFriends
//
//  Created by 신상원 on 2022/03/03.
//

import UIKit
import SnapKit

class SessacShopViewController: UIViewController, ViewRepresentable {
    
    let emptyImageView = UIView()
    let emptyTapView = UIView()
    let emptyButton = MyButton(frame: CGRect(), mode: .fill, text: "TEST")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupConstraints()
    }
    
    func setupView() {
        [emptyButton].forEach {
            view.addSubview($0)
        }
        emptyButton.backgroundColor = .blue
    }
    
    func setupConstraints() {
        emptyButton.snp.makeConstraints { make in
            make.centerY.leading.trailing.equalToSuperview()
            make.height.equalTo(100)
        }
    }
    
}
