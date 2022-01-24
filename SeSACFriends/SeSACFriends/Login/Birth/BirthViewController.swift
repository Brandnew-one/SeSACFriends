//
//  BirthViewController.swift
//  SeSACFriends
//
//  Created by 신상원 on 2022/01/22.
//

import UIKit

class BirthViewController: UIViewController {
    
    let birthView = BirthView()
    
    override func loadView() {
        view = birthView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        birthView.datePicker.datePickerMode = .date
        birthView.datePicker.locale = Locale(identifier: "ko_KO")
        birthView.datePicker.preferredDatePickerStyle = .wheels
        birthView.datePicker.addTarget(self, action: #selector(datepicked(_:)), for: .valueChanged)
        birthView.myButton.addTarget(self, action: #selector(buttonClicked), for: .touchUpInside)
        
        settingView()
    }
    
    @objc func buttonClicked() {
        print(birthView.datePicker.date)
        if birthView.myButton.mode == .fill {
            let formatter = DateFormatter()
            formatter.locale = Locale(identifier: "ko")
            formatter.dateFormat = "yyyy-MM-dd"
            LoginViewModel.shared.birth.value = formatter.string(from: birthView.datePicker.date)
            let vc = EmailViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        } else {
            self.view.makeToast("새싹친구는 만 17세 이상만 사용할 수 있습니다")
        }

    }
    
    //수정 필요
    func checkAge(pickedDate: Date) -> Bool {
        let today = Date()
        
        let date1 = Calendar.current.dateComponents([.year, .month, .day], from: today)
        let date2 = Calendar.current.dateComponents([.year, .month, .day], from: pickedDate)
        
        if date1.year! - date2.year! < 17 {
            return false
        } else if date1.year! - date2.year! == 17 {
            if date1.month! > date2.month! {
                return true
            } else if date1.month == date2.month {
                if date1.day! >= date2.day! {
                    return true
                } else {
                    return false
                }
            } else {
                return false
            }
        } else {
            return true
        }
    }
    
    @objc func datepicked(_ sender: UIDatePicker) {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko")
        formatter.dateFormat = "yyyy-MM-dd"
        let koDate = formatter.string(from: birthView.datePicker.date)
        
        if koDate.count == 10 {
            var makeString: String = ""
            for i in 0...3 {
                let makeIndex = koDate.index(koDate.startIndex, offsetBy: i)
                makeString.append(koDate[makeIndex])
            }
            birthView.yearView.dayLabel.text = makeString
            makeString = ""
            
            for i in 5...6 {
                let makeIndex = koDate.index(koDate.startIndex, offsetBy: i)
                makeString.append(koDate[makeIndex])
            }
            birthView.monthView.dayLabel.text = makeString
            makeString = ""
            
            for i in 8...9 {
                let makeIndex = koDate.index(koDate.startIndex, offsetBy: i)
                makeString.append(koDate[makeIndex])
            }
            birthView.dayView.dayLabel.text = makeString
            makeString = ""
        }
        
        if checkAge(pickedDate: birthView.datePicker.date) {
            birthView.myButton.setupMode(mode: .fill)
        } else {
            birthView.myButton.setupMode(mode: .disable)
        }
    }
    
    func settingView() {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko")
        formatter.dateFormat = "yyyy-MM-dd"
        birthView.datePicker.date = formatter.date(from: LoginViewModel.shared.birth.value) ?? Date()
        if LoginViewModel.shared.birth.value.count == 10 {
            let koDate = LoginViewModel.shared.birth.value
            var makeString: String = ""
            for i in 0...3 {
                let makeIndex = koDate.index(koDate.startIndex, offsetBy: i)
                makeString.append(koDate[makeIndex])
            }
            birthView.yearView.dayLabel.text = makeString
            makeString = ""
            
            for i in 5...6 {
                let makeIndex = koDate.index(koDate.startIndex, offsetBy: i)
                makeString.append(koDate[makeIndex])
            }
            birthView.monthView.dayLabel.text = makeString
            makeString = ""
            
            for i in 8...9 {
                let makeIndex = koDate.index(koDate.startIndex, offsetBy: i)
                makeString.append(koDate[makeIndex])
            }
            birthView.dayView.dayLabel.text = makeString
            makeString = ""
        }
        
        if checkAge(pickedDate: birthView.datePicker.date) {
            birthView.myButton.setupMode(mode: .fill)
        } else {
            birthView.myButton.setupMode(mode: .disable)
        }
    }
}


