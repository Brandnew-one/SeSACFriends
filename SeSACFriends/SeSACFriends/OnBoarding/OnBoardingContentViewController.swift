//
//  OnBoardingContentViewController.swift
//  SeSACFriends
//
//  Created by 신상원 on 2022/02/25.
//

import UIKit
import SnapKit

// MARK: 온보딩 1번
class OnBoardingContentViewController1: UIViewController, ViewRepresentable {
    
    let onBoardingView = OnBoardingView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupConstraints()
    }
    
    func setupView() {
        view.backgroundColor = .white
        view.addSubview(onBoardingView)
        onBoardingView.label.text = "위치 기반으로 빠르게\n주위 친구를 확인"
        onBoardingView.imageView.image = UIImage(named: ImageSet.onboardingImage1)
    }
    
    func setupConstraints() {
        onBoardingView.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalToSuperview()
        }
    }
}

// MARK: 온보딩 2번
class OnBoardingContentViewController2: OnBoardingContentViewController1 {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupConstraints()
    }
    
    override func setupView() {
        super.setupView()
        onBoardingView.label.text = "관심사가 같은 친구를\n찾을 수 있어요"
        onBoardingView.imageView.image = UIImage(named: ImageSet.onboardingImage2)
    }
}

// MARK: 온보딩 3번
class OnBoardingContentViewController3: OnBoardingContentViewController1 {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupConstraints()
    }
    
    override func setupView() {
        super.setupView()
        onBoardingView.label.text = "SeSAC Friends"
        onBoardingView.imageView.image = UIImage(named: ImageSet.onboardingImage3)
    }
    
    override func setupConstraints() {
        onBoardingView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(19)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
}
