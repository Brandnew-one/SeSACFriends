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
        
        birthView.myButton.addTarget(self, action: #selector(buttonClicked), for: .touchUpInside)
    }
    
    @objc func buttonClicked() {
        let vc = EmailViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
