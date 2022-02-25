//
//  StatusCodeSet.swift
//  SeSACFriends
//
//  Created by 신상원 on 2022/02/25.
//

import Foundation


struct StatusCode {
    
    static let success = 200
    static let successCase1 = 201
    static let successCase2 = 202
    static let successCase3 = 203
    static let tokenError = 401
    static let unknownUser = 406
    static let serverError = 500
    static let clientError = 501
}
