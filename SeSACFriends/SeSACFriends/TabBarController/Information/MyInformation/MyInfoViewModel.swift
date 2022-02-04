//
//  MyInfoViewModel.swift
//  SeSACFriends
//
//  Created by 신상원 on 2022/02/04.
//

import Foundation

class MyInfoViewModel {
    
    var user = Observable(User())
    
    func fetchUser(completion: @escaping () -> Void) {
        APIService.getUser { user, error, code in
            if let error = error {
                print("에러발생: ", error)
                return
            }
            if let code = code {
                if code == 401 {
                    print("Firebase Token Error")
                } else if code == 406 {
                    print("미가입 유저")
                } else if code == 500 {
                    print("Server Error")
                } else if code == 501 {
                    print("Client Error")
                } else { // code == 200
                    guard let user = user else {
                        return
                    }
                    self.user.value = user
                    completion()
                }
            }
        }
    }
    
    //escaping (String?) -> Void 형태로 토스트 수정해보기
    func updateMypage(completion: @escaping () -> Void) {
        let body = updateMypageForm(searchable: user.value.searchable, ageMin: user.value.ageMin, ageMax: user.value.ageMax, gender: user.value.gender, hobby: user.value.hobby)
        APIService.updateMyPage(body: body) { error, code in
            if let error = error {
                return
            }
            if let code = code {
                if code == 401 {
                    print("Firebase Token Error")
                } else if code == 406 {
                    print("미가입 유저")
                } else if code == 500 {
                    print("Server Error")
                } else if code == 501 {
                    print("Client Error")
                } else {
                    print("Success")
                    completion()
                }
            }
        }
    }
    
    
}
