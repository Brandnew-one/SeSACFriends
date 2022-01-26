//
//  InformationViewController.swift
//  SeSACFriends
//
//  Created by 신상원 on 2022/01/25.
//

import SnapKit
import UIKit

class InformationViewController: UIViewController {
    
    let informationView = InformationView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.title = "내 정보"
        setupView()
    }
    
    func setupView() {
        view.addSubview(informationView)
        informationView.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
}
