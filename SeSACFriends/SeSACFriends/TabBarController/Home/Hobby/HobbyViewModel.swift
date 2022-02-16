//
//  HobbyViewModel.swift
//  SeSACFriends
//
//  Created by 신상원 on 2022/02/10.
//

import Foundation

final class HobbyViewModel {
    
    var form = Observable(hobbyForm(type: 2, region: 0, long: 0.0, lat: 0.0, hf: []))
    
    func fetchHobbyFriends(completion: @escaping () -> Void) {
        print(form.value)
        APIService.searchHobbyFriends(body: form.value) { result, code in
            if let code = code {
                print("code: ", code)
                if code == 200 {
                    if let result = result {
                        print("result: ", result)
                    }
                    completion()
                }
                
            }
        }
    }
    
}
