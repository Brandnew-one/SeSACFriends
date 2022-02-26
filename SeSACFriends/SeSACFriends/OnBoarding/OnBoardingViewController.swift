//
//  OnBoardingViewController.swift
//  SeSACFriends
//
//  Created by 신상원 on 2022/02/25.
//

import UIKit
import SnapKit

class OnBoardingViewController: UIViewController, ViewRepresentable {
    
    let pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal)
    let pageControl = UIPageControl()
    let myButton = MyButton(frame: CGRect(), mode: .fill, text: "시작하기")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myButton.addTarget(self, action: #selector(startButtonClicked), for: .touchUpInside)
    }
    
    func setupView() {
        view.backgroundColor = .white
        [pageControl, myButton].forEach {
            view.addSubview($0)
        }
        
    }
    
    func setupConstraints() {
        <#code#>
    }
    
    func setupPageControl() {
        pageControl.currentPage = 0
        pageControl.numberOfPages = 3
        pageControl.backgroundColor = UIColor(rgbString: ColorSet.gray4)
        
    }
    
    @objc func startButtonClicked() {
        
    }
    
}
