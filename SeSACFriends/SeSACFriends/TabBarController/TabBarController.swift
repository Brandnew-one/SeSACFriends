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
        homeVC.tabBarItem.image = UIImage(named: "ic")
        
        let shopVC = UINavigationController(rootViewController: ShopViewController())
        shopVC.tabBarItem.title = "새싹샵"
        shopVC.tabBarItem.image = UIImage(named: "ic-1")
        
        let friendVC = UINavigationController(rootViewController: HomeViewController())
        friendVC.tabBarItem.title = "새싹친구"
        friendVC.tabBarItem.image = UIImage(named: "ic-2")
        
        let profileVC = UINavigationController(rootViewController: InformationViewController())
        profileVC.tabBarItem.title = "내 정보"
        profileVC.tabBarItem.image = UIImage(named: "ic-3")
        
        viewControllers = [homeVC, shopVC, friendVC, profileVC]
    }
    
}
