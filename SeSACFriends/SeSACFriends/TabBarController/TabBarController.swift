//
//  TabBarController.swift
//  SeSACFriends
//
//  Created by 신상원 on 2022/01/29.
//

import UIKit

class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tabBar.tintColor = UIColor(rgbString: ColorSet.green)
        
        let homeVC = UINavigationController(rootViewController: HomeViewController())
        homeVC.tabBarItem.title = "홈"
        
        let profileVC = UINavigationController(rootViewController: InformationViewController())
        profileVC.tabBarItem.title = "내 정보"
        
        viewControllers = [homeVC, profileVC]
        
    }
    
}
