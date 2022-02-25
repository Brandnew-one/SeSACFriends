//
//  ReviewViewModel.swift
//  SeSACFriends
//
//  Created by 신상원 on 2022/02/20.
//

import Foundation

class ReviewViewModel {
    
    var rateReview: RateReview = RateReview(otheruid: "", comment: "")
    
    func fetchRateReview(completion: @escaping (Int) -> Void) {
        APIService.makeReview(id: rateReview.otheruid, body: rateReview) { error, code in
            if let error = error {
                print("리뷰 남기기 에러발생")
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
                    } else { // code == 200
                        completion(code)
                    }
                }
            }
        }
    }
}
