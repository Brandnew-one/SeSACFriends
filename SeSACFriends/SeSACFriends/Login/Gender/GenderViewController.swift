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
