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
    let birth = Observable("")
    let email = Observable("")
    let gender = Observable(0)
    
    func fetchSignup(completion: @escaping (Int) -> Void) {
        let fcm = UserDefaults.standard.string(forKey: "FCMToken") ?? ""
        let phone = UserDefaults.standard.string(forKey: "phone") ?? ""
        let body = Signup(phoneNumber: phone, fcMtoken: fcm, nick: nick.value, birth: birth.value, email: email.value, gender: gender.value)
        
        APIService.signupUser(body: body) { error, code in
            if let error = error {
                print("네트워크 에러 발생")
            }
            if let code = code {
                completion(code)
            }
        }
    }
    
    func fetchWithdraw(completion: @escaping (Int) -> Void) {
        APIService.withdrawUser { error, code in
            if let error = error {
                print("네트워크 에러 발생")
            }
            if let code = code {
                completion(code)
            }
        }
    }
    
}
