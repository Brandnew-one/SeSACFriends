//
//  TabmanSearchViewController.swift
//  SeSACFriends
//
//  Created by 신상원 on 2022/02/12.
//

import Pageboy
import SnapKit
import Tabman

import UIKit


class TabmanSearchViewController: TabmanViewController {
    
    private var viewControllers: Array<UIViewController> = []
    private let vcName = ["주변새싹", "받은 요청"]
    let tapView = UIView()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupTabView()
        
        self.navigationItem.title = "새싹찾기"
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: ImageSet.backButton), style: .plain, target: self, action: #selector(backButtonClicked))
        self.navigationItem.leftBarButtonItem?.tintColor = UIColor(rgbString: ColorSet.black)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "찾기중단", style: .plain, target: self, action: #selector(stopButtonClicked))
        
        let nearVC = NearSesacViewController()
        let requestVC = RequestViewController()
        viewControllers.append(nearVC)
        viewControllers.append(requestVC)
        
        self.dataSource = self
        createBar()
    }
    
    @objc func backButtonClicked() {
        // 우선은 이전화면으로 가게 설정 -> 추후에 수정이 필요함
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func stopButtonClicked() {
        print(#function)
    }
    
    func setupTabView() {
        view.addSubview(tapView)
        tapView.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(44)
        }
    }
    
    func createBar() {
        let bar = TMBar.ButtonBar()
        bar.layout.transitionStyle = .snap
        bar.backgroundView.style = .blur(style: .regular)
        bar.buttons.customize { (button) in
            button.tintColor = UIColor(rgbString: ColorSet.gray6) // 선택 안되어 있을 때
            button.selectedTintColor = UIColor(rgbString: ColorSet.green) // 선택 되어 있을 때
            button.font = FontSet.title3M14!
        }
        // 인디케이터 조정
        bar.indicator.weight = .light
        bar.indicator.tintColor = UIColor(rgbString: ColorSet.green)
        bar.indicator.overscrollBehavior = .compress
        bar.layout.alignment = .centerDistributed
        bar.layout.contentMode = .fit
//        bar.layout.interButtonSpacing = 35 // 버튼 사이 간격
        
        // Add to view
        addBar(bar, dataSource: self, at: .custom(view: tapView, layout: nil))
    }
    
}

extension TabmanSearchViewController: PageboyViewControllerDataSource, TMBarDataSource {
    func barItem(for bar: TMBar, at index: Int) -> TMBarItemable {
        let item = TMBarItem(title: "")
        item.title = vcName[index]
        
        return item
    }
    
    func numberOfViewControllers(in pageboyViewController: PageboyViewController) -> Int {
        return viewControllers.count
    }

    func viewController(for pageboyViewController: PageboyViewController,
                        at index: PageboyViewController.PageIndex) -> UIViewController? {
        return viewControllers[index]
    }

    func defaultPage(for pageboyViewController: PageboyViewController) -> PageboyViewController.Page? {
        return nil
    }
}
