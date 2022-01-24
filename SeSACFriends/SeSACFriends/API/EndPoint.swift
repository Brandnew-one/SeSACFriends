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
    case dataError
    case responseError
    case decodeError
}

enum StatusCode: Int {
    case success = 200
    case already = 201
    case FbToken = 401
    case server = 500
    case client = 501
    case unknown
}

enum EndPoint {
    case getUser
    case signupUser
    case withdrawUser
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
        case .getUser: return .makeEndpoint("user") // 로그인
        case .signupUser: return .makeEndpoint("user") // 회원가입
        case .withdrawUser: return .makeEndpoint("user/withdraw")
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
    
    // Decode 한 데이터가 필요없는 통신의 경우
    static func request2(_ session: URLSession = .shared, endpoint: URLRequest, completion: @escaping (APIError?, Int?) -> Void) {
        session.dataTask(endpoint) { data, response, error in
            DispatchQueue.main.sync {
                guard error == nil else {
                    completion(.error, nil)
                    return
                }
                guard let data = data else {
                    completion(.dataError, nil)
                    return
                }
                guard let response = response as? HTTPURLResponse else {
                    completion(.responseError, nil)
                    return
                }
                completion(nil, response.statusCode)
            }
        }
    }
    
    static func request<T: Decodable>(_ session: URLSession = . shared, endpoint: URLRequest, completion: @escaping (T?, APIError?, StatusCode?) -> Void) {
        session.dataTask(endpoint) { data, response, error in
            
            DispatchQueue.main.async {
                guard error == nil else {
                    completion(nil, .error, nil)
                    return
                    
                }
                guard let data = data else {
                    completion(nil, .dataError, nil)
                    return
                    
                }
                guard let response = response as? HTTPURLResponse else {
                    completion(nil, .responseError, nil)
                    return
                }
                
                if response.statusCode == 201 {
                    completion(nil, nil, .already)
                } else if response.statusCode == 401 {
                    completion(nil, nil, .FbToken)
                } else if response.statusCode == 500 {
                    completion(nil, nil, .server)
                } else if response.statusCode == 501 {
                    completion(nil, nil, .client)
                } else if response.statusCode == 200 {
                    do {
                        let decoder = JSONDecoder()
                        let userData = try decoder.decode(T.self, from: data)
                        completion(userData, nil, .success) //성공적으로 통신에 성공한 경우
                    } catch {
                        completion(nil, .decodeError, nil)
                    }
                } else {
                    completion(nil, nil, .unknown)
                }
                return
            }
        }
    }
}
