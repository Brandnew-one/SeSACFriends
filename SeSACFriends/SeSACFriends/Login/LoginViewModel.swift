//
//  LoginViewModel.swift
//  SeSACFriends
//
//  Created by 신상원 on 2022/01/19.
//

import Foundation

class LoginViewModel {
    
    //화면 넘어가면서 저장해야 되니까 싱글턴패턴으로 구성
    static let shared = LoginViewModel()
    
    let verificationID = Observable("")
    let phoneNumber = Observable("")
    let token = Observable("")
    let nick = Observable("")
    let birth = Observable(Date())
    let email = Observable("")
    let gender = Observable(0)
    
}
