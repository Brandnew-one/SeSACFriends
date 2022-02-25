//
//  ReportViewModel.swift
//  SeSACFriends
//
//  Created by 신상원 on 2022/02/24.
//

import Foundation

class ReportViewModel {
    
    var reportUser: ReportUser = ReportUser(otheruid: "", reportedReputation: [0, 0, 0, 0, 0, 0], comment: "")
    
    func fetchReportUser(completion: @escaping (Int) -> Void) {
        APIService.userReport(id: reportUser.otheruid, body: self.reportUser) { error, code in
            if let error = error {
                print("신고하기 에러발생")
                return
            } else {
                if let code = code {
                    if code == StatusCode.tokenError {
                        print("Firebase Token Error")
                    } else if code == StatusCode.unknownUser {
                        print("미가입 회원")
                    } else if code == StatusCode.serverError {
                        print("Server Error")
                    } else if code == StatusCode.clientError {
                        print("Client Error")
                    } else if code == StatusCode.successCase1 {
                        completion(code)
                    } else { // code == 200
                        completion(code)
                    }
                }
            }
        }
    }
}
