//
//  HomeViewModel.swift
//  SeSACFriends
//
//  Created by 신상원 on 2022/02/08.
//

import CoreLocation
import Foundation

class HomeViewModel {
    
    var result = Observable(HomeModel(fromQueueDB: [], fromQueueDBRequested: [], fromRecommend: []))
    var hfArray: [String] = []
    var recommendIndex: Int = 0
    
    func fetchSearchFriends(location: CLLocationCoordinate2D, completion: @escaping () -> Void) {
        APIService.searchNearFriends(location: location) { result, error, code in
            if let error = error {
                print("Error 발생")
                return
            }
            if let code = code {
                if code == 401 {
                    print("Firebase Token Error")
                } else if code == 406 {
                    print("미가입 유저")
                } else if code == 500 {
                    print("Server Error")
                } else if code == 501 {
                    print("Client Error")
                } else { // code == 200
                    guard let result = result else {
                        return
                    }
                    self.result.value = result
//                    print(result)
                    completion()
                }
            }
        }
    }
    
    // 취미입력 화면에서 컬렉션 뷰를 채워주기 위해서 배열을 초기화
    func updatehfArray() {
        for str in result.value.fromRecommend {
            hfArray.append(str)
        }
        recommendIndex = result.value.fromRecommend.count - 1
        
        for arr in result.value.fromQueueDB {
            for hobby in arr.hf {
//                print(hobby)
                if hobby == "anything" {
                    continue
                } else {
                    hfArray.append(hobby)
                }
            }
        }
    }
    
}
