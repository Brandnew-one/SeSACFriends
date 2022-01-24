//
//  Login.swift
//  SeSACFriends
//
//  Created by 신상원 on 2022/01/20.
//

import Foundation

// 2개 어떻게 합칠까?

// MARK: LoginUser
struct Signup {
    var phoneNumber, fcMtoken, nick: String
    let birth: String
    let email: String
    let gender: Int

    enum CodingKeys: String, CodingKey {
        case phoneNumber
        case fcMtoken = "FCMtoken"
        case nick, birth, email, gender
    }
}

// MARK: - User
struct User: Codable {
    let id: String
    let reputation: [Int]
    let comment: [String]
    let sesacCollection, backgroundCollection: [Int]
    let purchaseToken, transactionID, reviewedBefore, reportedUser: [String]
    let uid, phoneNumber, fcMtoken, nick: String
    let birth, email: String
    let gender, sesac, background, ageMin: Int
    let ageMax, dodgeNum, searchable, reportedNum: Int
    let createdAt: String
    let v: Int

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case reputation, comment, sesacCollection, backgroundCollection, purchaseToken
        case transactionID = "transactionId"
        case reviewedBefore, reportedUser, uid, phoneNumber
        case fcMtoken = "FCMtoken"
        case nick, birth, email, gender, sesac, background, ageMin, ageMax, dodgeNum, searchable, reportedNum, createdAt
        case v = "__v"
    }
}
