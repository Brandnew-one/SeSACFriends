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
                    print(result)
                    completion()
                }
            }
        }
    }
    
}
