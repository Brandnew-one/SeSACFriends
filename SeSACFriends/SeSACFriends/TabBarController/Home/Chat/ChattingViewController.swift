//
//  ChattingViewController.swift
//  SeSACFriends
//
//  Created by 신상원 on 2022/02/18.
//

import SnapKit
import UIKit

class ChattingViewController: UIViewController {
    
    var homeViewModel = HomeViewModel()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false
        self.tabBarController?.tabBar.isHidden = true
        homeViewModel.myQueueState.bind { _ in
            self.navigationItem.title = "\(self.homeViewModel.myQueueState.value.matchedNick!)"
            print(self.homeViewModel.myQueueState.value.matchedUid)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: ImageSet.backButton), style: .plain, target: self, action: #selector(backButtonClicked))
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: ImageSet.more), style: .plain, target: self, action: #selector(moreButtonClicked))
    }
    
    @objc func backButtonClicked() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func moreButtonClicked() {
        print(#function)
        let vc = MoreViewController()
        vc.modalPresentationStyle = .overCurrentContext
        vc.modalTransitionStyle = .crossDissolve
        vc.homeViewModel = self.homeViewModel
        self.present(vc, animated: true, completion: nil)
    }
    
}
