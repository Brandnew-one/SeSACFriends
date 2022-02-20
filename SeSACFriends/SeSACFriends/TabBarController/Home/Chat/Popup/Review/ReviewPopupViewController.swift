//
//  ReviewPopupViewController.swift
//  SeSACFriends
//
//  Created by 신상원 on 2022/02/20.
//

import SnapKit
import UIKit

class ReviewPopupViewController: UIViewController, ViewRepresentable {
    
    var homeViewModel = HomeViewModel()
    var reviewViewModel = ReviewViewModel()
    var popupView = ReviewPopupView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupConstraints()
        setupButton()
        view.backgroundColor = .black.withAlphaComponent(0.5)
        
        popupView.textView.delegate = self
        popupView.textView.text =  "자세한 피드백은 다른새싹들에게 도움이 됩니다.\n(500자 이내 작성)"
        popupView.textView.textColor = UIColor(rgbString: ColorSet.gray7)
    }
    
    func setupView() {
        view.addSubview(popupView)
        popupView.backgroundColor = .white
        popupView.clipsToBounds = true
        popupView.layer.cornerRadius = 8
    }
    
    func setupConstraints() {
        popupView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(16.5)
            make.trailing.equalToSuperview().offset(-16.5)
            make.height.equalTo(450)
        }
    }
    
    func setupButton() {
        popupView.finalButton.addTarget(self, action: #selector(sendButtonClicked), for: .touchUpInside)
        popupView.closeButton.addTarget(self, action: #selector(closeButtonClicked), for: .touchUpInside)
        popupView.mybutton1.addTarget(self, action: #selector(mybuttonClicked1), for: .touchUpInside)
        popupView.mybutton2.addTarget(self, action: #selector(mybuttonClicked2), for: .touchUpInside)
        popupView.mybutton3.addTarget(self, action: #selector(mybuttonClicked3), for: .touchUpInside)
        popupView.mybutton4.addTarget(self, action: #selector(mybuttonClicked4), for: .touchUpInside)
        popupView.mybutton5.addTarget(self, action: #selector(mybuttonClicked5), for: .touchUpInside)
        popupView.mybutton6.addTarget(self, action: #selector(mybuttonClicked6), for: .touchUpInside)
    }
    
    @objc func sendButtonClicked() {
        reviewViewModel.rateReview.comment = popupView.textView.text
        reviewViewModel.rateReview.otheruid = homeViewModel.myQueueState.value.matchedUid!
        reviewViewModel.fetchRateReview { code in
            if code == 200 {
                UserDefaults.standard.set(0, forKey: UserDefautlsSet.state)
                guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return }
                windowScene.windows.first?.rootViewController = TabBarController()
                windowScene.windows.first?.makeKeyAndVisible()
            }
        }
    }
    
    @objc func closeButtonClicked() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func mybuttonClicked1() {
        if reviewViewModel.rateReview.reputation[0] == 0 {
            reviewViewModel.rateReview.reputation[0] = 1
            popupView.mybutton1.setupMode(mode: .fill)
        } else {
            reviewViewModel.rateReview.reputation[0] = 0
            popupView.mybutton1.setupMode(mode: .inactive)
        }
    }
    
    @objc func mybuttonClicked2() {
        if reviewViewModel.rateReview.reputation[1] == 0 {
            reviewViewModel.rateReview.reputation[1] = 1
            popupView.mybutton2.setupMode(mode: .fill)
        } else {
            reviewViewModel.rateReview.reputation[1] = 0
            popupView.mybutton2.setupMode(mode: .inactive)
        }
    }
    
    @objc func mybuttonClicked3() {
        if reviewViewModel.rateReview.reputation[2] == 0 {
            reviewViewModel.rateReview.reputation[2] = 1
            popupView.mybutton3.setupMode(mode: .fill)
        } else {
            reviewViewModel.rateReview.reputation[2] = 0
            popupView.mybutton3.setupMode(mode: .inactive)
        }
    }
    
    @objc func mybuttonClicked4() {
        if reviewViewModel.rateReview.reputation[3] == 0 {
            reviewViewModel.rateReview.reputation[3] = 1
            popupView.mybutton4.setupMode(mode: .fill)
        } else {
            reviewViewModel.rateReview.reputation[3] = 0
            popupView.mybutton4.setupMode(mode: .inactive)
        }
    }
    
    @objc func mybuttonClicked5() {
        if reviewViewModel.rateReview.reputation[4] == 0 {
            reviewViewModel.rateReview.reputation[4] = 1
            popupView.mybutton5.setupMode(mode: .fill)
        } else {
            reviewViewModel.rateReview.reputation[4] = 0
            popupView.mybutton5.setupMode(mode: .inactive)
        }
    }
    
    @objc func mybuttonClicked6() {
        if reviewViewModel.rateReview.reputation[5] == 0 {
            reviewViewModel.rateReview.reputation[5] = 1
            popupView.mybutton6.setupMode(mode: .fill)
        } else {
            reviewViewModel.rateReview.reputation[5] = 0
            popupView.mybutton6.setupMode(mode: .inactive)
        }
    }
    
}

extension ReviewPopupViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor(rgbString: ColorSet.gray7) {
            textView.text = nil
            textView.textColor = UIColor(rgbString: ColorSet.black)
        }
    }

  func textViewDidEndEditing(_ textView: UITextView) {
      if textView.text.isEmpty {
          textView.text = "자세한 피드백은 다른새싹들에게 도움이 됩니다.\n(500자 이내 작성)"
          textView.textColor = UIColor.lightGray
        }
    }
    
}
