//
//  OnBoardingViewController.swift
//  SeSACFriends
//
//  Created by 신상원 on 2022/02/25.
//

import UIKit
import SnapKit

class OnBoardingViewController: UIViewController, ViewRepresentable {
    
    var viewControllers: [UIViewController] = []
    let mainView = UIView()
    let pageControl = UIPageControl()
    let myButton = MyButton(frame: CGRect(), mode: .fill, text: "시작하기")
    var index = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupConstraints()
        setupPageControl()
        
        viewControllers.append(OnBoardingContentViewController1())
        viewControllers.append(OnBoardingContentViewController2())
        viewControllers.append(OnBoardingContentViewController3())
        initPageViewController()
        
        myButton.addTarget(self, action: #selector(startButtonClicked), for: .touchUpInside)
    }
    
    func setupView() {
        view.backgroundColor = .white
        [mainView, pageControl, myButton].forEach {
            view.addSubview($0)
        }
    }
    
    func setupConstraints() {
        mainView.snp.makeConstraints { make in
            make.leading.trailing.top.equalToSuperview()
            make.bottom.equalToSuperview().offset(-200)
        }
        
        myButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.bottom.equalToSuperview().offset(-50)
            make.height.equalTo(48)
        }
        
        pageControl.snp.makeConstraints { make in
            make.bottom.equalTo(myButton.snp.top).offset(-42)
            make.centerX.equalToSuperview()
            make.width.equalTo(48)
            make.height.equalTo(8)
        }
    }
    
    func initPageViewController() {
        let pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal)
        pageViewController.dataSource = self
        pageViewController.delegate = self
        
        pageViewController.view.frame = mainView.frame
        pageViewController.setViewControllers([viewControllers[0]], direction: .reverse, animated: true, completion: nil)
        
        mainView.addSubview(pageViewController.view)
        self.addChild(pageViewController)
    }
    
    func setupPageControl() {
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        pageControl.currentPage = 0
        pageControl.numberOfPages = 3
        pageControl.currentPageIndicatorTintColor = .black
        pageControl.pageIndicatorTintColor = UIColor(rgbString: ColorSet.gray4)
    }
    
    @objc func startButtonClicked() {
        print(#function)
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return }
        windowScene.windows.first?.rootViewController = UINavigationController(rootViewController: LoginViewController())
        windowScene.windows.first?.makeKeyAndVisible()
    }
    
}

extension OnBoardingViewController: UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
            guard let currentIndex = viewControllers.firstIndex(of: viewController) else { return nil }
            
            if currentIndex == 0 {
                return nil
            } else {
                return viewControllers[currentIndex - 1]
            }
        }
        
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let currentIndex = viewControllers.firstIndex(of: viewController) else { return nil }
        
        if currentIndex < viewControllers.count - 1 {
            return viewControllers[currentIndex + 1]
        } else {
            return nil
        }
    }
    
}
