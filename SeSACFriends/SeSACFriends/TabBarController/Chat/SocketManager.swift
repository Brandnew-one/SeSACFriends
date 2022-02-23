//
//  SocketManager.swift
//  SeSACFriends
//
//  Created by 신상원 on 2022/02/23.
//

import Foundation
import SocketIO

class SocketIOManager: NSObject {
    
    static let shared = SocketIOManager()
    
    // 서버와 메시지를 주고받기 위한 클래스
    var manager: SocketManager!
    // 클라이언트 소켓
    var socket: SocketIOClient!
    
    override init() {
        super.init()
        
        let url = URL(string: "http://test.monocoding.com:35484")!
        manager = SocketManager(socketURL: url, config: [
            .log(true),
            .compress
        ])
        socket = manager.defaultSocket
        
        // 소켓 연결 메서드
        socket.on(clientEvent: .connect) { data, ack in
            print("SOCKET IS CONNECTED", data, ack)
            self.socket.emit("changesocketid", UserDefaults.standard.string(forKey: UserDefautlsSet.myID)!)
        }
        
        
        // 소켓 연결 해제 메서드
        socket.on(clientEvent: .disconnect) { data, ack in
            print("SOCKET IS DISCONNECTED", data, ack)
        }
        
        // 소켓 채팅 듣는 메서드 (sesac 이벤트로 날아온 데이터를 수신)
        // 소켓통신이 되면 우리가 따로 데이터를 요청하지 않아도 날아온다
        // 데이터 수신 -> 디코딩 -> 모델에 추가 -> 갱신
        socket.on("chat") { dataArray, ack in
            print("SESAC RECEIVED", dataArray, ack)
            
            let data = dataArray[0] as! NSDictionary
            let v = data["__v"] as! Int
            let id = data["_id"] as! String
            let chat = data["chat"] as! String
            let from = data["from"] as! String
            let to = data["to"] as! String
            let createdAt = data["createdAt"] as! String

            print("CHECK ", id, chat, createdAt)
            NotificationCenter.default.post(name: NSNotification.Name("getMessage"), object: self, userInfo: ["_id": id, "__v": v, "to": to, "from": from, "chat": chat, "createdAt": createdAt])
        }
    }
    
    func establishConnection() {
        socket.connect()
    }
    
    func closeConnection() {
        socket.disconnect()
    }
    
}
