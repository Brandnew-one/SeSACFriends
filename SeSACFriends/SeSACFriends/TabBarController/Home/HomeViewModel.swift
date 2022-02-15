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
    
    func fetchRequestHobby(uid: String, completion: @escaping (Int) -> Void) {
        APIService.requestHobby(otheruid: uid) { result, code in
            if let code = code {
                if code == 401 {
                    print("Firebase Token Error")
                } else if code == 406 {
                    print("미가입 유저")
                } else if code == 500 {
                    print("Server Error")
                } else if code == 501 {
                    print("Client Error")
                } else if code == 202 {
                    print("상대방이 친구찾기를 중단한 상태")
                    completion(code)
                } else if code == 201 {
                    print("상대방이 이미 나에게 취미 함께 하기를 요청한 상태")
                    completion(code)
                } else {
                    print("성공")
                    completion(code)
                }
            }
        }
    }
    
    func fetchAcceptHobby(otheruid: String, completion: @escaping (Int) -> Void) {
        APIService.acceptHobby(otheruid: otheruid) { result, code in
            if let code = code {
                if code == 401 {
                    print("Firebase Token Error")
                } else if code == 406 {
                    print("미가입 유저")
                } else if code == 500 {
                    print("Server Error")
                } else if code == 501 {
                    print("Client Error")
                } else if code == 203 {
                    print("내가 이미 다른 사람과 매칭된 상태")
                    completion(code)
                } else if code == 202 {
                    print("상대방이 취미함께 하기를 중단한 상태")
                    completion(code)
                } else if code == 201 {
                    print("상대방이 이미 다른 사람과 취미를 함께 하는 중입니다")
                    completion(code)
                } else {
                    print("취미함께하기 수락 성공")
                    completion(code)
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
