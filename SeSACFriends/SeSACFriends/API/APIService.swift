//
//  APIService.swift
//  SeSACFriends
//
//  Created by 신상원 on 2022/01/20.
//

import Foundation

class APIService {
    
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
    
    static func signupUser(body: Signup, completion: @escaping (APIError?, Int?) -> Void) {
        let url = EndPoint.signupUser.url
        guard let token = UserDefaults.standard.string(forKey: "FBToken") else {
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = Method.POST.rawValue
        request.setValue(token, forHTTPHeaderField: "idtoken")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    
        let json = signupForm(phoneNumber: body.phoneNumber, FCMtoken: body.fcMtoken, nick: body.nick, birth: body.birth, email: body.email, gender: body.gender)
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        let jsonData = try? encoder.encode(json)
        request.httpBody = jsonData
        
        URLSession.request2(endpoint: request, completion: completion)
    }
    
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
    
    static func updateMyPage(body: updateMypageForm, completion: @escaping (APIError?, Int?) -> Void) {
        let url = EndPoint.updateMyPage.url
        guard let token = UserDefaults.standard.string(forKey: "FBToken") else {
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = Method.POST.rawValue
        request.setValue(token, forHTTPHeaderField: "idtoken")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    
        let json = updateMypageForm(searchable: body.searchable, ageMin: body.ageMin, ageMax: body.ageMax, gender: body.gender, hobby: body.hobby)
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        let jsonData = try? encoder.encode(json)
        request.httpBody = jsonData
        
        URLSession.request2(endpoint: request, completion: completion)
    }
}
