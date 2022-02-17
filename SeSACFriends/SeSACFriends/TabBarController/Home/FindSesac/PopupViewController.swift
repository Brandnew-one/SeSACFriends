//
//  PopupViewController.swift
//  SeSACFriends
//
//  Created by 신상원 on 2022/02/14.
//

import SnapKit
import Toast_Swift

import UIKit

enum VCMode {
    case accept
    case request
}

class PopupViewController: UIViewController, ViewRepresentable {

    var mode: VCMode = .accept
    var popupView = PopupView()
    var homeviewModel = HomeViewModel()
    var completion: ((Int) -> Void)?
    var index = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black.withAlphaComponent(0.5)
        setupView()
        setupConstraints()
        setupText()
        
        popupView.okButtoon.addTarget(self, action: #selector(okButtonClicked), for: .touchUpInside)
        popupView.cancleButton.addTarget(self, action: #selector(cancleButtonClicked), for: .touchUpInside)
    }
    
    @objc func cancleButtonClicked() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func okButtonClicked() {
        print(#function)
        if mode == .request {
            homeviewModel.fetchRequestHobby(uid: homeviewModel.result.value.fromQueueDB[index].uid) { code in
                self.completion?(code)
            }
        } else {
            homeviewModel.fetchAcceptHobby(otheruid: homeviewModel.result.value.fromQueueDBRequested[index].uid) { code in
                print(self.homeviewModel.result.value.fromQueueDBRequested[self.index].nick)
                print(self.homeviewModel.result.value.fromQueueDBRequested[self.index].uid)
                self.completion?(code)
            }
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    func setupView() {
        view.addSubview(popupView)
    }
    
    func setupConstraints() {
        popupView.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func setupText() {
        if mode == .accept {
            popupView.titleLabel.text = "취미 같이 하기를 수락할까요?"
            popupView.contentLabel.text = "요청을 수락하면 채팅방에서 대화를 나눌 수 있어요"
        } else {
            popupView.titleLabel.text = "취미 같이 하기를 요청할게요!"
            popupView.contentLabel.text = "요청이 수락되면 30분 후에 리뷰를 남길 수 있어요"
        }
    }
    
    
}
