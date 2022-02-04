//
//  Login.swift
//  SeSACFriends
//
//  Created by 신상원 on 2022/01/20.
//

import Foundation

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
// 구조체 멤버와이즈 이니셜라이저가 정상적으로 동작하지 않아서 클래스로 우선 만듬
class User: Codable {
    let id: String
    let reputation: [Int]
    let comment: [String]
    let sesacCollection, backgroundCollection: [Int]
    let purchaseToken, transactionID, reviewedBefore, reportedUser: [String]
    let uid, phoneNumber, fcMtoken, nick: String
    let birth, email: String
    var gender, sesac: Int
    var hobby: String
    var dodgepenalty, background, ageMin, ageMax: Int
    var dodgeNum, searchable, reportedNum: Int
    let createdAt: String
    let v: Int

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case reputation, comment, sesacCollection, backgroundCollection, purchaseToken
        case transactionID = "transactionId"
        case reviewedBefore, reportedUser, uid, phoneNumber
        case fcMtoken = "FCMtoken"
        case nick, birth, email, gender, sesac, hobby, dodgepenalty, background, ageMin, ageMax, dodgeNum, searchable, reportedNum, createdAt
        case v = "__v"
    }

    init() {
        self.id = ""
        self.reputation = []
        self.comment = []
        self.sesacCollection = []
        self.backgroundCollection = []
        self.purchaseToken = []
        self.transactionID = []
        self.reviewedBefore = []
        self.reportedUser = []
        self.uid = ""
        self.phoneNumber = ""
        self.fcMtoken = ""
        self.nick = ""
        self.birth = ""
        self.email = ""
        self.gender = -1
        self.sesac = 0
        self.hobby = ""
        self.dodgepenalty = 0
        self.background = 0
        self.ageMin = 0
        self.ageMax = 0
        self.dodgeNum = 0
        self.searchable = 0
        self.reportedNum = 0
        self.createdAt = ""
        self.v = 0
    }
}

