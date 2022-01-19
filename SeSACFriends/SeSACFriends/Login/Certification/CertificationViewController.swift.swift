//
//  CertificationViewController.swift
//  SeSACFriends
//
//  Created by 신상원 on 2022/01/19.
//

import SnapKit
import Toast_Swift

import UIKit

// 휴대폰 전화번호 인증화면
class CertificationViewController: UIViewController {
    
    let certificationView = CertificationView()
    var timer: DispatchSourceTimer?
    var remainingTime: Int = 300
    
    override func loadView() {
        view = certificationView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        let tapGesture = UITapGestureRecognizer(target: view, action: #selector(view.endEditing))
        view.addGestureRecognizer(tapGesture)
        certificationView.textField.keyboardType = .numberPad
        
        startTimer()
        
        certificationView.sendButton.addTarget(self, action: #selector(buttonClicked), for: .touchUpInside)
    }
    
    //다시 인증번호를 요구하는 로직 필요
    @objc func buttonClicked() {
        startTimer()
    }
    
    //Start & Reset
    func startTimer() {
        //타이머가 처음 동작하는 경우
        if self.timer == nil {
            self.timer = DispatchSource.makeTimerSource(flags: [], queue: .main)
            //1초 간격으로 아래의 event 가 발생한다고 생각
            self.timer?.schedule(deadline: .now(), repeating: 1)
            self.timer?.setEventHandler(handler: { [weak self] in
                guard let self = self else { return }
                self.remainingTime -= 1
                let min = (self.remainingTime % 3600) / 60
                let sec = (self.remainingTime % 3600) % 60
                self.certificationView.timerLabel.text = String(format: "%02d:%02d", min,sec)
                
                //지정된 시간이 모두 흐른경우
                if self.remainingTime <= 0 {
                    self.stopTimer()
                }
            })
            self.timer?.resume()
        } else { // 인증번호를 다시 받는 경우
            stopTimer()
            remainingTime = 300
            startTimer()
        }
    }
    
    func stopTimer() {
        self.timer?.cancel()
        self.timer = nil //nil 로 메모리 해제 필요!
    }
    
    
}
