//
//  APIService.swift
//  SeSACFriends
//
//  Created by 신상원 on 2022/01/20.
//

import Foundation

class APIService {
    
    static func getUser(token: String, completion: @escaping (Login?, APIError?) -> Void) {
        
        let url = EndPoint.getUser.url
        var request = URLRequest(url: url)
        request.httpMethod = Method.GET.rawValue
        request.setValue(token, forHTTPHeaderField: "idtoken")
        
        URLSession.request(endpoint: request, completion: completion)
    }
    
}
