//
//  EndPoint.swift
//  SeSACFriends
//
//  Created by 신상원 on 2022/01/20.
//

import Foundation

enum Method: String {
    case GET
    case POST
    case PUT
    case DELETE
}

// API 통신하면서 에러코드 세분화 필요
enum APIError {
    case error
    case userError
    case tokenError
    case serverError
    case clientError
}

enum EndPoint {
    case getUser
}

extension URL {
    static let baseURL = "http://test.monocoding.com:35484/"
    
    static func makeEndpoint(_ endpoint: String) -> URL {
        URL(string: baseURL + endpoint)!
    }
}

extension EndPoint {
    var url: URL {
        switch self {
        case .getUser: return .makeEndpoint("user")
        
        }
    }
}

extension URLSession {
    
    typealias Handler = (Data?, URLResponse?, Error?) -> Void
    
    @discardableResult
    func dataTask(_ endpoint: URLRequest, handler: @escaping Handler) -> URLSessionDataTask {
        let task = dataTask(with: endpoint, completionHandler: handler)
        task.resume()
        return task
    }
    
    static func request<T: Decodable>(_ session: URLSession = . shared, endpoint: URLRequest, completion: @escaping (T?, APIError?) -> Void) {
        session.dataTask(endpoint) { data, response, error in
            
            DispatchQueue.main.async {
                guard error == nil else {
                    completion(nil, .error)
                    return
                    
                }
                guard let data = data else {
                    completion(nil, .error)
                    return
                    
                }
                guard let response = response as? HTTPURLResponse else {
                    completion(nil, .error)
                    return
                }
                
                if !(200...299).contains(response.statusCode) {
                    if response.statusCode == 401 {
                        completion(nil, .tokenError)
                    } else {
                        completion(nil, .tokenError)
                    }
                    return
                }
                
                do {
                    let decoder = JSONDecoder()
                    let userData = try decoder.decode(T.self, from: data)
                    completion(userData, nil) //성공적으로 통신에 성공한 경우
                } catch {
                    completion(nil, .error)
                }
            }
        }
    }
}
