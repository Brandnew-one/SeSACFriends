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

struct updateMypageForm: Codable {
    var searchable: Int
    var ageMin: Int
    var ageMax: Int
    var gender: Int
    var hobby: String
}

struct hobbyForm {
    var type: Int
    var region: Int
    var long: Double
    var lat: Double
    var hf: [String]
}

struct queueState: Codable {
    var dodged: Int?
    var matched: Int?
    var reviewed: Int?
    var matchedNick: String?
    var matchedUid: String?
}

struct RateReview: Codable {
    var otheruid: String
    var reputation = [0, 0, 0, 0, 0, 0, 0, 0, 0]
    var comment: String
}

struct ReportUser: Codable {
    var otheruid: String
    var reportedReputation = [0, 0, 0, 0, 0, 0]
    var comment: String
}
