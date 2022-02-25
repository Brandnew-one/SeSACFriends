//
//  HomeViewModel.swift
//  SeSACFriends
//
//  Created by 신상원 on 2022/02/08.
//

import CoreLocation
import Foundation
import UIKit

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
                if code == StatusCode.tokenError {
                    print("Firebase Token Error")
                } else if code == StatusCode.unknownUser {
                    print("미가입 유저")
                } else if code == StatusCode.serverError {
                    print("Server Error")
                } else if code == StatusCode.clientError {
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
                if code == StatusCode.tokenError {
                    print("Firebase Token Error")
                } else if code == StatusCode.unknownUser {
                    print("미가입 유저")
                } else if code == StatusCode.serverError {
                    print("Server Error")
                } else if code == StatusCode.clientError {
                    print("Client Error")
                } else if code == StatusCode.successCase2 {
                    print("상대방이 친구찾기를 중단한 상태")
                    completion(code)
                } else if code == StatusCode.successCase1 {
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
                if code == StatusCode.tokenError {
                    print("Firebase Token Error")
                } else if code == StatusCode.unknownUser {
                    print("미가입 유저")
                } else if code == StatusCode.serverError {
                    print("Server Error")
                } else if code == StatusCode.clientError {
                    print("Client Error")
                } else if code == StatusCode.successCase3 {
                    print("내가 이미 다른 사람과 매칭된 상태")
                    completion(code)
                } else if code == StatusCode.successCase2 {
                    print("상대방이 취미함께 하기를 중단한 상태")
                    completion(code)
                } else if code == StatusCode.successCase1 {
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
                if code == StatusCode.unknownUser {
                    print("미가입 회원")
                } else if code == StatusCode.serverError {
                    print("Server Error")
                } else if code == StatusCode.tokenError {
                    print("FireBase Token Error -> 추가적으로 구현 필요")
                } else if code == StatusCode.successCase1 {
                    print("이미 친구와 매칭된 상태")
                    completion(code)
                } else { // code == 200
                    print("취미 함께할 친구 찾기중단 성공")
                    completion(code)
                }
            }
        }
    }
    
    func fetchMyQueueState(completion: @escaping (Int) -> Void) {
        APIService.checkMyQueueState { result, error, code in
            if let error = error {
                print("에러 발생", error)
                // 201번에서 Decode Error 가 발생하는 것을 확인 (급한대로 일단 수정)
                if let code = code {
                    if code == StatusCode.successCase1 {
                        completion(code)
                    }
                }
            } else {
                if let code = code {
                    if code == StatusCode.serverError {
                        print("Server Error")
                        return
                    } else if code == StatusCode.unknownUser {
                        print("미가입 회원")
                        return
                    } else if code == StatusCode.tokenError {
                        print("firebase Token Error")
                        return
                    } else if code == StatusCode.successCase1 {
                        print("친구찾기 중단이 된 상태")
                        guard let result = result else {
                            return
                        }
                        completion(code)
                    } else { // code == 200
                        print("queue 상태 확인 성공")
                        guard let result = result else {
                            return
                        }
                        self.myQueueState.value = result
                        completion(code)
                    }
                }
            }
        }
    }
    
    func fetchDodgeHobby(id: String, completion: @escaping (Int) -> Void) {
        print(#function, "id: ", id)
        APIService.cancelHobby(otheruid: id) { error, code in
            if let error = error {
                print("취미함께하기 약속 취소 에러", error)
            }
            if let code = code {
                if code == StatusCode.serverError {
                    print("Server Error")
                    return
                } else if code == StatusCode.clientError {
                    print("Server Error")
                    return
                }
                else if code == StatusCode.unknownUser {
                    print("미가입 회원")
                    return
                } else if code == StatusCode.tokenError {
                    print("firebase Token Error")
                    return
                } else if code == StatusCode.successCase1 {
                    print("잘못된 Uid")
                    return
                } else { // code == 200
                    print("약속취소 성공")
                    completion(code)
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
