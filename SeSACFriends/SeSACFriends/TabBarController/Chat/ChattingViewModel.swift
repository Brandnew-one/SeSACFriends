//
//  ChattingViewModel.swift
//  SeSACFriends
//
//  Created by 신상원 on 2022/02/23.
//

import Foundation

class ChattingViewModel {
    
    var chatModel = Observable(ChatModel(payload: []))
    
    func fetchChatHistory(id: String, date: String, completion: @escaping (Int) -> Void) {
        APIService.historyChat(id: id, date: date) { result, error, code in
            if let error = error {
                print("채팅 기록 불러오기 에러", error)
            } else {
                if let code = code {
                    if code == 501 {
                        print("Client Error")
                        return
                    } else if code == 500 {
                        print("Server")
                        return
                    } else if code == 406 {
                        print("미가입 회원")
                        return
                    } else if code == 401 {
                        print("Firebase Token Error")
                        return
                    } else { // code == 200
                        if let result = result {
                            self.chatModel.value = result
                            completion(code)
                        }
                    }
                }
            }
        }
    }
    
    func sendChatting(id: String, chat: String, completion: @escaping (Int) -> Void) {
        APIService.sendChat(id: id, chat: chat) { error, code in
            if let error = error {
                print("채팅 보내기 에러", error)
            } else {
                if let code = code {
                    if code == 501 {
                        print("Client Error")
                        return
                    } else if code == 500 {
                        print("Server")
                        return
                    } else if code == 406 {
                        print("미가입 회원")
                        return
                    } else if code == 401 {
                        print("Firebase Token Error")
                        return
                    } else if code == 201 {
                        completion(code)
                    } else { // code == 200
                        completion(code)
                    }
                }
            }
        }
    }
}
