//
//  ChattingModel.swift
//  SeSACFriends
//
//  Created by 신상원 on 2022/02/23.
//

import Foundation

// MARK: - ChatModel
struct ChatModel: Codable {
    var payload: [Payload]
}

// MARK: - Payload
struct Payload: Codable {
    let id: String
    let v: Int
    let to, from, chat, createdAt: String

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case v = "__v"
        case to, from, chat, createdAt
    }
}
