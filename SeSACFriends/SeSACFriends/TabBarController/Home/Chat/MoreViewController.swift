//
//  MoreViewController.swift
//  SeSACFriends
//
//  Created by 신상원 on 2022/02/19.
//

import SnapKit
import UIKit

class MoreViewController: UIViewController, ViewRepresentable {
    
    let moreView = MoreView()
    var homeViewModel = HomeViewModel()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        homeViewModel.myQueueState.bind {_ in
            self.moreView.userLabel.text = "\(self.homeViewModel.myQueueState.value.matchedNick!)"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black.withAlphaComponent(0.5)
        setupView()
        setupConstraints()
        
        moreView.backButton.addTarget(self, action: #selector(backButtonClicked), for: .touchUpInside)
        moreView.cancleButtonView.button.addTarget(self, action: #selector(cancelButtonClicked), for: .touchUpInside)
    }
    
    func setupView() {
        view.addSubview(moreView)
    }
    
    func setupConstraints() {
        moreView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(48)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(116)
        }
    }
    
    @objc func backButtonClicked() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func cancelButtonClicked() {
        guard let pvc = self.presentingViewController else { return }
        let vc = CanclePopupViewController()
        vc.modalPresentationStyle = .overCurrentContext
        vc.modalTransitionStyle = .crossDissolve
        vc.homeviewModel = self.homeViewModel
        self.dismiss(animated: false) {
          pvc.present(vc, animated: true, completion: nil)
        }
    }
    
}
