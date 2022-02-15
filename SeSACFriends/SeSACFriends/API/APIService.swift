//
//  APIService.swift
//  SeSACFriends
//
//  Created by 신상원 on 2022/01/20.
//

import CoreLocation
import Foundation

class APIService {
    
    //MARK: 내 정보 확인하기
    static func getUser(completion: @escaping (User?, APIError?, Int?) -> Void) {
        
        let url = EndPoint.getUser.url
        guard let token = UserDefaults.standard.string(forKey: "FBToken") else {
            return
        }
//        print(token)
        var request = URLRequest(url: url)
        request.httpMethod = Method.GET.rawValue
        request.setValue(token, forHTTPHeaderField: "idtoken")
        
        URLSession.request(endpoint: request, completion: completion)
    }
    
    //MARK: 회원가입
    static func signupUser(body: Signup, completion: @escaping (APIError?, Int?) -> Void) {
        let url = EndPoint.signupUser.url
        guard let token = UserDefaults.standard.string(forKey: "FBToken") else {
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = Method.POST.rawValue
        request.setValue(token, forHTTPHeaderField: "idtoken")
        
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpBody = "phoneNumber=\(body.phoneNumber)&FCMtoken=\(body.fcMtoken)&nick=\(body.nick)&birth=\(body.birth)&email=\(body.email)&gender=\(body.gender)".data(using: .utf8, allowLossyConversion: false)
        
        URLSession.request2(endpoint: request, completion: completion)
    }
    
    //MARK: 회원탈퇴
    static func withdrawUser(completion: @escaping (APIError?, Int?) -> Void) {
        let url = EndPoint.withdrawUser.url
        guard let token = UserDefaults.standard.string(forKey: "FBToken") else {
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = Method.POST.rawValue
        request.setValue(token, forHTTPHeaderField: "idtoken")
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        
        URLSession.request2(endpoint: request, completion: completion)
    }
    
    //MARK: 내 정보 업데이트하기
    static func updateMyPage(body: updateMypageForm, completion: @escaping (APIError?, Int?) -> Void) {
        let url = EndPoint.updateMyPage.url
        guard let token = UserDefaults.standard.string(forKey: UserDefautlsSet.firebaseToken) else {
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = Method.POST.rawValue
        request.httpBody = "searchable=\(body.searchable)&ageMin=\(body.ageMin)&ageMax=\(body.ageMax)&gender=\(body.gender)&hobby=\(body.hobby)".data(using: .utf8, allowLossyConversion: false)
        request.setValue(token, forHTTPHeaderField: "idtoken")
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
    
        URLSession.request2(endpoint: request, completion: completion)
    }
    
    //MARK: 주변 새싹 탐색
    static func searchNearFriends(location: CLLocationCoordinate2D, completion: @escaping (HomeModel?, APIError?, Int?) -> Void) {
        let url = EndPoint.onqueue.url
        guard let token = UserDefaults.standard.string(forKey: UserDefautlsSet.firebaseToken) else {
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = Method.POST.rawValue
        var latitude = Double(location.latitude)
        var longitude = Double(location.longitude)
        var region = findRegion(Location: location)
        
        request.httpBody = "region=\(region)&lat=\(latitude)&long=\(longitude)".data(using: .utf8, allowLossyConversion: false)
        request.setValue(token, forHTTPHeaderField: "idtoken")
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        
        URLSession.request(endpoint: request, completion: completion)
    }
    
    //MARK: 취미 함께할 친구 찾기
    static func searchHobbyFriends(body: hobbyForm, completion: @escaping (APIError?, Int?) -> Void) {
        let url = EndPoint.hobby.url
        guard let token = UserDefaults.standard.string(forKey: UserDefautlsSet.firebaseToken) else {
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = Method.POST.rawValue
        request.httpBody = "type=\(body.type)&region=\(body.region)&long=\(body.long)&lat=\(body.lat)&hf=\(body.hf)".data(using: .utf8, allowLossyConversion: false)
        request.setValue(token, forHTTPHeaderField: "idtoken")
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        
        URLSession.request2(endpoint: request, completion: completion)
    }
    
    //MARK: 취미함께 하기 요청
    static func requestHobby(otheruid: String, completion: @escaping (APIError?, Int?) -> Void) {
        let url = EndPoint.hobbyRequest.url
        guard let token = UserDefaults.standard.string(forKey: UserDefautlsSet.firebaseToken) else {
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = Method.POST.rawValue
        request.httpBody = "otheruid=\(otheruid)".data(using: .utf8, allowLossyConversion: false)
        request.setValue(token, forHTTPHeaderField: "idtoken")
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        
        URLSession.request2(endpoint: request, completion: completion)
    }
    
    //MARK: 취미함께하기 수락
    static func acceptHobby(otheruid: String, completion: @escaping (APIError?, Int?) -> Void) {
        let url = EndPoint.hobbyRequest.url
        guard let token = UserDefaults.standard.string(forKey: UserDefautlsSet.firebaseToken) else {
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = Method.POST.rawValue
        request.httpBody = "otheruid=\(otheruid)".data(using: .utf8, allowLossyConversion: false)
        request.setValue(token, forHTTPHeaderField: "idtoken")
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        
        URLSession.request2(endpoint: request, completion: completion)
    }
    
}

extension APIService {
    
    //MARK: lat, long 을 기준으로 region 을 계산하는 함수
    static func findRegion(Location: CLLocationCoordinate2D) -> Int {
        var latitude = Double(Location.latitude)
        latitude += 90
        var longitude = Double(Location.longitude)
        longitude += 180
        
        var latitudeString = String(latitude)
        var longitudeString = String(longitude)
        latitudeString = latitudeString.components(separatedBy: ["."]).joined()
        longitudeString = longitudeString.components(separatedBy: ["."]).joined()
        
        var answer = ""
        var index = 0
        for str in latitudeString {
            if(index == 5) {
                break
            }
            index += 1
            answer.append(str)
        }
        index = 0
        for str in longitudeString {
            if(index == 5) {
                break
            }
            index += 1
            answer.append(str)
        }
        
//        print(latitude)
//        print(longitude)
//        print(answer)
        
        return Int(answer) ?? 0
    }
    
}
