//
//  HomeViewController.swift
//  SeSACFriends
//
//  Created by 신상원 on 2022/01/23.
//

import CoreLocation
import UIKit
import MapKit

class HomeViewController: UIViewController, ViewRepresentable {
    
    let homeView = HomeView()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupView()
        setupConstraints()
    }
    
    func setupView() {
        view.addSubview(homeView)
    }
    
    func setupConstraints() {
        homeView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
}
