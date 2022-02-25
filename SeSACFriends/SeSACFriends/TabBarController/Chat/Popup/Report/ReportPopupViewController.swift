//
//  ReportPopupViewController.swift
//  SeSACFriends
//
//  Created by 신상원 on 2022/02/19.
//

import Toast_Swift
import SnapKit

import UIKit

class ReportPopupViewController: UIViewController, ViewRepresentable {
    
    var homeViewModel = HomeViewModel()
    var popupView = ReportPopupView()
    var reportViewModel = ReportViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black.withAlphaComponent(0.5)
        setupView()
        setupConstraints()
        setupButton()
        
        popupView.textView.delegate = self
        popupView.textView.text =  "신고사유를 적어주세요\n허위 신고 시 제재를 받을 수 있습니다"
        popupView.textView.textColor = UIColor(rgbString: ColorSet.gray7)
        
        // 탭하면 키보드 사라지도록 구현
        let tapGesture = UITapGestureRecognizer(target: view, action: #selector(view.endEditing))
        view.addGestureRecognizer(tapGesture)
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
            make.height.equalTo(410)
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
        reportViewModel.reportUser.comment = popupView.textView.text
        reportViewModel.reportUser.otheruid = homeViewModel.myQueueState.value.matchedUid!
        reportViewModel.fetchReportUser { code in
            if code == StatusCode.successCase1 {
                self.view.makeToast("이미 신고한 유저 입니다")
            } else if code == StatusCode.success {
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
        if reportViewModel.reportUser.reportedReputation[0] == 0 {
            reportViewModel.reportUser.reportedReputation[0] = 1
            popupView.mybutton1.setupMode(mode: .fill)
        } else {
            reportViewModel.reportUser.reportedReputation[0] = 0
            popupView.mybutton1.setupMode(mode: .inactive)
        }
    }
    
    @objc func mybuttonClicked2() {
        if reportViewModel.reportUser.reportedReputation[1] == 0 {
            reportViewModel.reportUser.reportedReputation[1] = 1
            popupView.mybutton2.setupMode(mode: .fill)
        } else {
            reportViewModel.reportUser.reportedReputation[1] = 0
            popupView.mybutton2.setupMode(mode: .inactive)
        }
    }
    
    @objc func mybuttonClicked3() {
        if reportViewModel.reportUser.reportedReputation[2] == 0 {
            reportViewModel.reportUser.reportedReputation[2] = 1
            popupView.mybutton3.setupMode(mode: .fill)
        } else {
            reportViewModel.reportUser.reportedReputation[2] = 0
            popupView.mybutton3.setupMode(mode: .inactive)
        }
    }
    
    @objc func mybuttonClicked4() {
        if reportViewModel.reportUser.reportedReputation[3] == 0 {
            reportViewModel.reportUser.reportedReputation[3] = 1
            popupView.mybutton4.setupMode(mode: .fill)
        } else {
            reportViewModel.reportUser.reportedReputation[3] = 0
            popupView.mybutton4.setupMode(mode: .inactive)
        }
    }
    
    @objc func mybuttonClicked5() {
        if reportViewModel.reportUser.reportedReputation[4] == 0 {
            reportViewModel.reportUser.reportedReputation[4] = 1
            popupView.mybutton5.setupMode(mode: .fill)
        } else {
            reportViewModel.reportUser.reportedReputation[4] = 0
            popupView.mybutton5.setupMode(mode: .inactive)
        }
    }
    
    @objc func mybuttonClicked6() {
        if reportViewModel.reportUser.reportedReputation[5] == 0 {
            reportViewModel.reportUser.reportedReputation[5] = 1
            popupView.mybutton6.setupMode(mode: .fill)
        } else {
            reportViewModel.reportUser.reportedReputation[5] = 0
            popupView.mybutton6.setupMode(mode: .inactive)
        }
    }
    
}

extension ReportPopupViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor(rgbString: ColorSet.gray7) {
            textView.text = nil
            textView.textColor = UIColor(rgbString: ColorSet.black)
        }
    }

  func textViewDidEndEditing(_ textView: UITextView) {
      if textView.text.isEmpty {
          textView.text = "신고사유를 적어주세요\n허위 신고 시 제재를 받을 수 있습니다"
          textView.textColor = UIColor.lightGray
          popupView.finalButton.setupMode(mode: .disable)
      } else {
          popupView.finalButton.setupMode(mode: .fill)
      }
    }
    
}
