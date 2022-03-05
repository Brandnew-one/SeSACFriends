//
//  Alert+Extension.swift
//  SeSACFriends
//
//  Created by 신상원 on 2022/02/06.
//

import UIKit

// MARK: Alert
extension UIViewController {
    
    func showAlert(title: String, message: String, okTitle: String, okAction: @escaping () -> ()) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        
        let ok = UIAlertAction(title: okTitle, style: .default) { _ in
            print("확인 버튼 눌렀음")
            okAction()
        }
        
        alert.addAction(cancel)
        alert.addAction(ok)
        
        self.present(alert, animated: true) {
            print("얼럿이 떴습니다.")
        }
    }
}

// MARK: Image
extension UIViewController {
    
    func setBackgroundImage(background: Int) -> UIImage {
        if background == 0 {
            return UIImage(named: ImageSet.background1)!
        } else if background == 1 {
            return UIImage(named: ImageSet.background2)!
        } else if background == 2 {
            return UIImage(named: ImageSet.background3)!
        } else if background == 3 {
            return UIImage(named: ImageSet.background4)!
        } else if background == 4 {
            return UIImage(named: ImageSet.background5)!
        } else if background == 5 {
            return UIImage(named: ImageSet.background6)!
        } else if background == 6 {
            return UIImage(named: ImageSet.background7)!
        } else {
            return UIImage(named: ImageSet.background8)!
        }
    }
    
    func getIntfromBackgroundImage(image: UIImage) -> Int {
        if image == UIImage(named: ImageSet.background1) {
            return 0
        } else if image == UIImage(named: ImageSet.background2) {
            return 1
        } else if image == UIImage(named: ImageSet.background3) {
            return 2
        } else if image == UIImage(named: ImageSet.background4) {
            return 3
        } else if image == UIImage(named: ImageSet.background5) {
            return 4
        } else if image == UIImage(named: ImageSet.background6) {
            return 5
        } else if image == UIImage(named: ImageSet.background7) {
            return 6
        } else if image == UIImage(named: ImageSet.background8) {
            return 7
        } else {
            return 10 // Error
        }
    }
    
    func setSesacFaceImage(sesac: Int) -> UIImage {
        if sesac == 0 {
            return UIImage(named: ImageSet.face1)!
        } else if sesac == 1 {
            return UIImage(named: ImageSet.face2)!
        } else if sesac == 2 {
            return UIImage(named: ImageSet.face3)!
        } else if sesac == 3 {
            return UIImage(named: ImageSet.face4)!
        } else {
            return UIImage(named: ImageSet.face5)!
        }
    }
    
    func getIntfromSesacImage(image: UIImage) -> Int {
        if image == UIImage(named: ImageSet.face1) {
            return 0
        } else if image == UIImage(named: ImageSet.face2) {
            return 1
        } else if image == UIImage(named: ImageSet.face3) {
            return 2
        } else if image == UIImage(named: ImageSet.face4) {
            return 3
        } else if image == UIImage(named: ImageSet.face5) {
            return 4
        } else {
            return 10 // Error
        }
    }
    
}

// MARK: Navigation Controller
extension UIViewController {
    // pop back N viewcontroller
    func popBack(_ count: Int) {
        if let viewControllers: [UIViewController] = self.navigationController?.viewControllers {
            guard viewControllers.count < count else {
                self.navigationController?.popToViewController(viewControllers[viewControllers.count - count], animated: true)
                return
            }
        }
    }
}
