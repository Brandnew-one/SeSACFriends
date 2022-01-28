//
//  MyInformationViewController.swift
//  SeSACFriends
//
//  Created by 신상원 on 2022/01/28.
//

import SnapKit
import UIKit

class MyInformationViewController: UIViewController {
    
    let myInfoView = MyInfoView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.title = "정보 관리"
        
        let tapGesture = UITapGestureRecognizer(target: view, action: #selector(view.endEditing))
        view.addGestureRecognizer(tapGesture)
        setupView()
    }
    
    func setupView() {
        view.addSubview(myInfoView)
        myInfoView.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
}
