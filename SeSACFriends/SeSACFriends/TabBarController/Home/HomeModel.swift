//
//  HomeModel.swift
//  SeSACFriends
//
//  Created by 신상원 on 2022/02/08.
//

//MARK: Onqueue
import Foundation

// MARK: - HomeModel
struct HomeModel: Codable {
    let fromQueueDB: [QueueDB]
    let fromQueueDBRequested: [QueueDB]
    let fromRecommend: [String]
}

// MARK: - QueueDB
struct QueueDB: Codable {
    let hf: [String]
    let reviews: [String]
    let reputation: [Int]
    let uid, nick: String
    let gender, type, sesac, background: Int
    let long, lat: Double
}
