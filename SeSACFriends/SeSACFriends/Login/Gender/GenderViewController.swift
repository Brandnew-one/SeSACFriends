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
            if code == 200 {
                guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return }
                windowScene.windows.first?.rootViewController = UINavigationController(rootViewController: HomeViewController())
                windowScene.windows.first?.makeKeyAndVisible()
            } else if code == 201 {
                self.view.makeToast("이미 가입한 유저입니다")
            } else if code == 202 {
                self.view.makeToast("사용할 수 없는 닉네임입니다")
            } else {
                self.view.makeToast("네트워크 오류입니다")
            }
        }
    }
    
    @objc func mainViewTapped() {
//        print(#function)
        genderView.maleView.backgroundColor = UIColor(rgbString: ColorSet.white)
        genderView.femaleView.backgroundColor = UIColor(rgbString: ColorSet.white)
        LoginViewModel.shared.gender.value = 2
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
    
}
