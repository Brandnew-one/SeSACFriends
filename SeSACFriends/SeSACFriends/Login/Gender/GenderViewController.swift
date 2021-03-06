//
//  GenderViewController.swift
//  SeSACFriends
//
//  Created by 신상원 on 2022/01/21.
//

import UIKit

class GenderViewController: UIViewController {
    
    let genderView = GenderView()
    
    override func loadView() {
        view = genderView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setText()
        settingView()
        
        //target: self 로 안하면 오류 (키보드 내리는건 왜 잘 동작하는 걸까?)
        let mainGesture = UITapGestureRecognizer(target: self, action: #selector(mainViewTapped))
        view.addGestureRecognizer(mainGesture)
        view.isUserInteractionEnabled = true
        
        let maleGesture = UITapGestureRecognizer(target: self, action: #selector(maleViewTapped))
        genderView.maleView.addGestureRecognizer(maleGesture)
        genderView.maleView.isUserInteractionEnabled = true
        
        let femaleGesture = UITapGestureRecognizer(target: self, action: #selector(femaleViewTapped))
        genderView.femaleView.addGestureRecognizer(femaleGesture)
        genderView.femaleView.isUserInteractionEnabled = true
        
        genderView.myButton.addTarget(self, action: #selector(myButtonClicked), for: .touchUpInside)
    }
    
    @objc func myButtonClicked() {
        LoginViewModel.shared.fetchSignup { code in
            if code == StatusCode.success {
                guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return }
                windowScene.windows.first?.rootViewController = TabBarController()
                windowScene.windows.first?.makeKeyAndVisible()
            } else if code == StatusCode.successCase1 {
                self.view.makeToast("이미 가입한 유저입니다")
            } else if code == StatusCode.successCase2 {
                self.view.makeToast("사용할 수 없는 닉네임입니다")
                guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return }
                windowScene.windows.first?.rootViewController = UINavigationController(rootViewController: NicknameViewController())
                windowScene.windows.first?.makeKeyAndVisible()
            } else if code == StatusCode.tokenError {
                self.view.makeToast("다시 시도해주세요")
            } else {
                print(code)
                self.view.makeToast("네트워크 오류입니다")
            }
        }
    }
    
    @objc func mainViewTapped() {
//        print(#function)
        genderView.maleView.backgroundColor = UIColor(rgbString: ColorSet.white)
        genderView.femaleView.backgroundColor = UIColor(rgbString: ColorSet.white)
        LoginViewModel.shared.gender.value = -1
        genderView.myButton.setupMode(mode: .disable)
    }
    
    @objc func maleViewTapped() {
//        print(#function)
        genderView.maleView.backgroundColor = UIColor(rgbString: ColorSet.whiteGreen)
        genderView.femaleView.backgroundColor = UIColor(rgbString: ColorSet.white)
        LoginViewModel.shared.gender.value = 1
        genderView.myButton.setupMode(mode: .fill)
    }
    
    @objc func femaleViewTapped() {
//        print(#function)
        genderView.maleView.backgroundColor = UIColor(rgbString: ColorSet.white)
        genderView.femaleView.backgroundColor = UIColor(rgbString: ColorSet.whiteGreen)
        LoginViewModel.shared.gender.value = 0
        genderView.myButton.setupMode(mode: .fill)
    }
    
    func setText() {
        genderView.mainLabel.text = "성별을 선택해 주세요"
        genderView.subLabel.text = "새싹 찾기 기능을 이용하기 위해서 필요해요!"
        genderView.maleView.imageLable.text = "남자"
        genderView.femaleView.imageLable.text = "여자"
    }
    
    // 사용자가 화면을 다시 돌아왔을 때(닉네임) 입력값을 화면에 보여주기 위해서
    func settingView() {
        if LoginViewModel.shared.gender.value == -1 {
            genderView.maleView.backgroundColor = UIColor(rgbString: ColorSet.white)
            genderView.femaleView.backgroundColor = UIColor(rgbString: ColorSet.white)
            genderView.myButton.setupMode(mode: .disable)
        } else if LoginViewModel.shared.gender.value == 0 {
            genderView.maleView.backgroundColor = UIColor(rgbString: ColorSet.white)
            genderView.femaleView.backgroundColor = UIColor(rgbString: ColorSet.whiteGreen)
            genderView.myButton.setupMode(mode: .fill)
        } else {
            genderView.maleView.backgroundColor = UIColor(rgbString: ColorSet.whiteGreen)
            genderView.femaleView.backgroundColor = UIColor(rgbString: ColorSet.white)
            genderView.myButton.setupMode(mode: .fill)
        }
    }
}
