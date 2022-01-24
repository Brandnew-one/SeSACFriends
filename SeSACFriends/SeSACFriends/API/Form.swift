//
//  Form.swift
//  SeSACFriends
//
//  Created by 신상원 on 2022/01/24.
//

import Foundation

// Json 파일로 Encode 해주기 위해서
struct signupForm: Codable {
    var phoneNumber: String
    var FCMtoken: String
    var nick: String
    var birth: String
    var email: String
    var gender: Int
}
