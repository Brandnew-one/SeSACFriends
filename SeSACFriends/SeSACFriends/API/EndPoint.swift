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

enum EndPoint {
    case getUser
    case signupUser
    case withdrawUser
    case updateMyPage
    case onqueue
    case hobby
    case hobbyRequest
    case hobbyAccept
    case myQueueState
    case rate(id: String)
    case dodge
    case report
    case chat(id: String)
    case chatHistroy(id: String, lastchatDate: String)
    case shopMyInfo
    case purchaseItem
    case updateShop
    case purchaseItemIAP
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
        case .withdrawUser: return .makeEndpoint("user/withdraw") // 회원탈퇴
        case .updateMyPage: return .makeEndpoint("user/update/mypage") // 내 정보 업데이트
        case .onqueue: return .makeEndpoint("queue/onqueue") // 주변 새싹 탐색 기능
        case .hobby: return .makeEndpoint("queue") // 취미입력 화면
        case .hobbyRequest: return .makeEndpoint("queue/hobbyrequest") // 취미함께 하기 요청
        case .hobbyAccept: return .makeEndpoint("queue/hobbyaccept") // 취미함께 하기 수락
        case .myQueueState: return .makeEndpoint("queue/myQueueState") // 매칭상태 확인하기
        case .rate(id: let id): return.makeEndpoint("queue/rate/\(id)") // 리뷰남기기
        case .dodge: return.makeEndpoint("queue/dodge") // 취미함께하기 취소하기
        case .report: return.makeEndpoint("user/report") // 신고하기
        case .chat(id: let id): return.makeEndpoint("chat/\(id)") // 채팅전송
        case .chatHistroy(id: let id, lastchatDate: let lastchatDate): return.makeEndpoint("chat/\(id)?lastchatDate=\(lastchatDate)") // 채팅 내용 요청
        case .shopMyInfo: return .makeEndpoint("user/shop/myinfo") // 새싹 샵 내 정보요청
        case .purchaseItem: return .makeEndpoint("user/shop/purchaseItem") // 새싹 샵 인앱결제x
        case .updateShop: return .makeEndpoint("user/update/shop") // 프로필, 배경화면 업데이트
        case .purchaseItemIAP: return .makeEndpoint("user/shop/ios") //새싹 샵 인앱결제o
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
    
    static func request<T: Decodable>(_ session: URLSession = . shared, endpoint: URLRequest, completion: @escaping (T?, APIError?, Int?) -> Void) {
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
                do {
                    let decoder = JSONDecoder()
                    let userData = try decoder.decode(T.self, from: data)
                    completion(userData, nil, response.statusCode) //성공적으로 통신에 성공한 경우
                } catch {
                    completion(nil, .decodeError, response.statusCode)
                }
                return
            }
        }
    }
}
