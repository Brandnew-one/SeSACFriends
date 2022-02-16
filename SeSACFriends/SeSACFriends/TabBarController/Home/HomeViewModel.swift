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
    var myQueueState = Observable(queueState(dodged: -1, matched: -1, reviewed: -1, matchedNick: "", matchedUid: ""))
    
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
        APIService.requestHobby(otheruid: uid) { error, code in
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
        APIService.acceptHobby(otheruid: otheruid) { error, code in
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
    
    func stopSearchingHobbyFriends(completion: @escaping (Int) -> Void) {
        APIService.stopHobbyFriends { error, code in
            if let code = code {
                if code == 406 {
                    print("미가입 회원")
                } else if code == 500 {
                    print("Server Error")
                } else if code == 401 {
                    print("FireBase Token Error -> 추가적으로 구현 필요")
                } else if code == 201 {
                    print("이미 친구와 매칭된 상태")
                    completion(code)
                } else { // code == 200
                    print("취미 함께할 친구 찾기중단 성공")
                    completion(code)
                }
            }
        }
    }
    
    func fetchMyQueueState(completion: @escaping (queueState, Int) -> Void) {
        APIService.checkMyQueueState { result, error, code in
            if let error = error {
                print("에러 발생")
            } else {
                if let code = code {
                    if code == 500 {
                        print("Server Error")
                        return
                    } else if code == 406 {
                        print("미가입 회원")
                        return
                    } else if code == 401 {
                        print("firebase Token Error")
                        return
                    } else if code == 201 {
                        print("친구찾기 중단이 된 상태")
                        guard let result = result else {
                            return
                        }
                        completion(result, code)
                    } else { // code == 200
                        print("queue 상태 확인 성공")
                        guard let result = result else {
                            return
                        }
                        completion(result, code)
                    }
                }
            }
        }
    }
    
    
    // 취미입력 화면에서 컬렉션 뷰를 채워주기 위해서 배열을 초기화
    func updatehfArray() {
        for str in result.value.fromRecommend {
            if !hfArray.contains(str) {
                hfArray.append(str)
            }
        }
        recommendIndex = result.value.fromRecommend.count - 1
        
        for arr in result.value.fromQueueDB {
            for hobby in arr.hf {
//                print(hobby)
                if hobby == "anything" {
                    continue
                } else if !hfArray.contains(hobby) {
                    hfArray.append(hobby)
                }
            }
        }
    }
    
}
