//
//  MyInformationViewController.swift
//  SeSACFriends
//
//  Created by 신상원 on 2022/01/28.
//

import Toast_Swift
import SnapKit

import UIKit

class MyInformationViewController: UIViewController {
    
    var myInfoViewModel = MyInfoViewModel()
    var myInfoView = MyInfoView()
    var toggle: Bool = false
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
        self.tabBarController?.tabBar.isTranslucent = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        // bar 버튼 색깔 안바뀌는 이슈 수정하기!
        let attributes = [NSAttributedString.Key.font: FontSet.title3M14, NSAttributedString.Key.foregroundColor:UIColor(rgbString: ColorSet.black)]
        UINavigationBar.appearance().titleTextAttributes = attributes
        
        navigationItem.title = "정보 관리"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "저장", style: .plain, target: self, action: #selector(saveButtonClicked))
        
        let tapGesture = UITapGestureRecognizer(target: view, action: #selector(view.endEditing))
        view.addGestureRecognizer(tapGesture)
        
        setupView()
        myInfoView.myCardView.titleView.isHidden = true
        myInfoView.myCardView.reviewView.isHidden = true
        myInfoView.myCardView.nameView.toggleButton.addTarget(self, action: #selector(toggleButtonClicked), for: .touchUpInside)
        myInfoView.myWithdrawView.button.addTarget(self, action: #selector(withdrawButtonClicked), for: .touchUpInside)
        myInfoView.myGenderView.maleButton.addTarget(self, action: #selector(maleButtonTapped), for: .touchUpInside)
        myInfoView.myGenderView.femaleButton.addTarget(self, action: #selector(femaleButtonTapped), for: .touchUpInside)
        
        myInfoViewModel.fetchUser {
            self.updateView()
        }
        
    }
    
    @objc func saveButtonClicked() {
        print("저장버튼 눌림")
        
        if myInfoView.myPhoneView.phoneSwitch.isOn {
            myInfoViewModel.user.value.searchable = 1
        } else {
            myInfoViewModel.user.value.searchable = 0
        }
        
        myInfoViewModel.user.value.ageMin = myInfoView.myAgeView.ageSlider.lowerValueStepIndex + 18
        myInfoViewModel.user.value.ageMax = myInfoView.myAgeView.ageSlider.upperValueStepIndex + 18
        myInfoViewModel.user.value.hobby = myInfoView.myHobbyView.myTextField.textField.text ?? ""
        
        myInfoViewModel.updateMypage {
            self.view.makeToast("사용자 정보가 수정되었습니다.")
        }
    }
    
    @objc func maleButtonTapped() {
        myInfoViewModel.user.value.gender = 1
        myInfoView.myGenderView.maleButton.backgroundColor = UIColor(rgbString: ColorSet.green)
        myInfoView.myGenderView.maleButton.setTitleColor(UIColor(rgbString: ColorSet.white), for: .normal)
        myInfoView.myGenderView.femaleButton.backgroundColor = UIColor(rgbString: ColorSet.white)
        myInfoView.myGenderView.femaleButton.setTitleColor(UIColor(rgbString: ColorSet.black), for: .normal)
    }
    
    @objc func femaleButtonTapped() {
        myInfoViewModel.user.value.gender = 0
        myInfoView.myGenderView.maleButton.backgroundColor = UIColor(rgbString: ColorSet.white)
        myInfoView.myGenderView.maleButton.setTitleColor(UIColor(rgbString: ColorSet.black), for: .normal)
        myInfoView.myGenderView.femaleButton.backgroundColor = UIColor(rgbString: ColorSet.green)
        myInfoView.myGenderView.femaleButton.setTitleColor(UIColor(rgbString: ColorSet.white), for: .normal)
    }
    
    @objc func toggleButtonClicked() {
        print("더 보기 버튼 눌림")
        if toggle { // 늘어나 있으면 줄여준다
            toggle = !toggle
            myInfoView.myCardView.titleView.isHidden = true
            myInfoView.myCardView.reviewView.isHidden = true
        } else {
            toggle = !toggle
            myInfoView.myCardView.titleView.isHidden = false
            myInfoView.myCardView.reviewView.isHidden = false
        }
    }
    
    @objc func withdrawButtonClicked() {
        print("회원탈퇴 눌림")
        let vc = WithdrawPopupViewController()
        vc.modalPresentationStyle = .overCurrentContext
        vc.modalTransitionStyle = .crossDissolve
        self.present(vc, animated: true, completion: nil)
    }
    
    func setupView() {
        view.addSubview(myInfoView)
        myInfoView.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func updateView() {
        // 새싹 타이틀
//        TEST
//        myInfoViewModel.user.value.reputation[0] = 1
//        myInfoViewModel.user.value.reputation[2] = 1
//        myInfoViewModel.user.value.reputation[4] = 1
        
        var index = 0
        for rep in myInfoViewModel.user.value.reputation {
            if index >= 6 {
                break
            }
            if rep > 0 {
                myInfoView.myCardView.titleView.cellTitles[index].setupMode(isOn: true)
            }
            index += 1
        }
        
        // 새싹 리뷰
        if myInfoViewModel.user.value.comment.isEmpty {
            myInfoView.myCardView.reviewView.setupMode(review: nil)
        } else {
            myInfoView.myCardView.reviewView.setupMode(review: myInfoViewModel.user.value.comment.first)
        }
        
        // 이름
        myInfoView.myCardView.nameView.nameLabel.text = myInfoViewModel.user.value.nick
        
        // 성별
        if myInfoViewModel.user.value.gender == 0 {
            myInfoView.myGenderView.femaleButton.backgroundColor = UIColor(rgbString: ColorSet.green)
            myInfoView.myGenderView.femaleButton.setTitleColor(UIColor(rgbString: ColorSet.white), for: .normal)
        } else if myInfoViewModel.user.value.gender == 1 {
            myInfoView.myGenderView.maleButton.backgroundColor = UIColor(rgbString: ColorSet.green)
            myInfoView.myGenderView.maleButton.setTitleColor(UIColor(rgbString: ColorSet.white), for: .normal)
        }
        // 자주하는 취미
        myInfoView.myHobbyView.myTextField.textField.text = myInfoViewModel.user.value.hobby
        
        //내 번호 검색 허용
        if myInfoViewModel.user.value.searchable == 0 {
            myInfoView.myPhoneView.phoneSwitch.isOn = false
        } else {
            myInfoView.myPhoneView.phoneSwitch.isOn = true
        }
        
        // 상대방 연령대
        myInfoView.myAgeView.ageSlider.lowerValueStepIndex = myInfoViewModel.user.value.ageMin - 18
        myInfoView.myAgeView.ageSlider.upperValueStepIndex = myInfoViewModel.user.value.ageMax - 18
        myInfoView.myAgeView.ageLabel.text = "\(myInfoViewModel.user.value.ageMin) - \(myInfoViewModel.user.value.ageMax)"
    }
    
}

