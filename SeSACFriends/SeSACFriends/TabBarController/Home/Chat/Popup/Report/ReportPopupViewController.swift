//
//  ReportPopupViewController.swift
//  SeSACFriends
//
//  Created by 신상원 on 2022/02/19.
//

import SnapKit
import UIKit

class ReportPopupViewController: UIViewController, ViewRepresentable {
    
    var popupView = ReportPopupView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black.withAlphaComponent(0.5)
        setupView()
        setupConstraints()
        setupButton()
        
        popupView.textView.delegate = self
        popupView.textView.text =  "신고사유를 적어주세요\n허위 신고 시 제재를 받을 수 있습니다"
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
            make.height.equalTo(410)
        }
    }
    
    func setupButton() {
        popupView.closeButton.addTarget(self, action: #selector(closeButtonClicked), for: .touchUpInside)
    }
    
    @objc func closeButtonClicked() {
        self.dismiss(animated: true, completion: nil)
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
        }
    }
    
}
