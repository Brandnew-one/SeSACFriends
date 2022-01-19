//
//  LoginModel.swift
//  SeSACFriends
//
//  Created by 신상원 on 2022/01/19.
//

import Foundation

struct Login: Codable {
    let phonNumber: String
    let FCMtoken: String
    let nick: String
    let birth: String
    let email: String
    let gender: Int
}
