//
//  BackgroundShopViewController.swift
//  SeSACFriends
//
//  Created by 신상원 on 2022/03/03.
//

import UIKit
import SnapKit

class BackgroundShopViewController: UIViewController, ViewRepresentable {
    
    let emptyImageView = UIView()
    let emptyTapView = UIView()
    let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupConstraints()
    }
    
    func setupView() {
        [emptyImageView, emptyTapView, tableView].forEach {
            view.addSubview($0)
        }
        emptyImageView.backgroundColor = .clear
        emptyTapView.backgroundColor = .clear
        tableView.backgroundColor = .systemGray2
    }
    
    func setupConstraints() {
        emptyImageView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(15)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(14)
            make.trailing.equalTo(view.safeAreaLayoutGuide).offset(-12.8)
            make.height.equalTo(174.61)
        }
        
        emptyTapView.snp.makeConstraints { make in
            make.top.equalTo(emptyImageView.snp.bottom)
            make.leading.trailing.equalToSuperview().inset(1)
            make.height.equalTo(44)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(emptyTapView.snp.bottom).offset(4)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
    
}
