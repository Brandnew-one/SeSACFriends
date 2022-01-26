//
//  SceneDelegate.swift
//  SeSACFriends
//
//  Created by 신상원 on 2022/01/18.
//

import FirebaseAuth
import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene:  windowScene)
        window?.windowScene = windowScene
        window?.rootViewController = UINavigationController(rootViewController: InformationViewController())
        
//        //1) 처음 앱을 켰을 때 FB에 가입을 한 user 인 경우, idtoken을 갱신만 해준다
//        // 만약 FB 가입을 하지않은 user 의 경우, 휴대폰 전화 인증을 통해서 FB에 가입을 시켜준다. (FCM 토큰 분기 처리 필요!)
//        let currentUser = Auth.auth().currentUser
//        currentUser?.getIDTokenForcingRefresh(true) { idToken, error in
//            if let error = error {
//                print("error:", error.localizedDescription)
//                self.window?.rootViewController = UINavigationController(rootViewController: LoginViewController())
//                return;
//            } else {
//                // FB에 가입을 한 user의 경우, SeSAC Friends 서비스에 회원가입을 한 user 인지 확인한다. (GET/USER)
//                UserDefaults.standard.set(idToken!, forKey: "FBToken") // 토큰 갱신
//                APIService.getUser { user, error, code in
//                    if let code = code {
//                        if code == 200 { // 회원가입을 한 유저
//                            self.window?.rootViewController = UINavigationController(rootViewController: HomeViewController())
//                        } else if code == 201 { // 회원가입을 하지 않은 유저
//                            self.window?.rootViewController = UINavigationController(rootViewController: NicknameViewController())
//                        } else {
//                            print("Code ERROR")
//                            print(code)
//                        }
//                    } else {
//                        print(error)
//                        print("네트워크 통신 오류")
//                    }
//                }
//            }
//        }
        window?.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

