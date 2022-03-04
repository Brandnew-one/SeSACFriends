//
//  ShopViewController.swift
//  SeSACFriends
//
//  Created by 신상원 on 2022/03/03.
//

import UIKit

import Pageboy
import SnapKit
import Tabman

class ShopViewController: TabmanViewController, ViewRepresentable {
    
    private var viewControllers: Array<UIViewController> = []
    private let vcName = ["새싹", "배경"]
    let backgroundTitles = ["하늘공원", "씨티 뷰", "밤의 산책로", "낮의 산책로", "연극 무대", "라틴 거실", "홈트방", "뮤지션 작업실"]
    let backgroundContents = [
        "새싹들을 많이 마주치는 매력적인 하늘 공원입니다", "창밖으로 보이는 도시 야경이 아름다운 공간입니다", "어둡지만 무섭지 않은 조용한 산책로입니다", "즐겁고 가볍게 걸을 수 있는 산책로입니다",
        "연극의 주인공이 되어 연기를 펼칠 수 있는 무대입니다", "모노톤의 따스한 감성의 거실로 편하게 쉴 수 있는 공간입니다", "집에서 운동을 할 수 있도록 기구를 갖춘 방입니다", "여러가지 음악 작업을 할 수 있는 작업실입니다"
    ]
    var tapView = UIView()
    var shopImageView = ShopImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupConstraints()
        
        self.navigationItem.title = "새싹샵"
        let sesacVC = SessacShopViewController()
        let backgroundVC = BackgroundShopViewController()
        viewControllers.append(sesacVC)
        viewControllers.append(backgroundVC)
        
        self.dataSource = self
        createBar()
        shopImageView.button.addTarget(self, action: #selector(buttonClicked), for: .touchUpInside)
        
        backgroundVC.tableView.delegate = self
        backgroundVC.tableView.dataSource = self
        backgroundVC.tableView.separatorColor = .clear
//        backgroundVC.tableView.rowHeight = UITableView.automaticDimension
        backgroundVC.tableView.register(BackgroundTableViewCell.self, forCellReuseIdentifier: BackgroundTableViewCell.identifier)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false
        self.tabBarController?.tabBar.isHidden = false
    }
    
    func setupView() {
        view.backgroundColor = .white
        [shopImageView, tapView].forEach {
            view.addSubview($0)
        }
    }
    
    func setupConstraints() {
        shopImageView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(15)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(14)
            make.trailing.equalTo(view.safeAreaLayoutGuide).offset(-12.8)
            make.height.equalTo(174.61)
        }
        
        tapView.snp.makeConstraints { make in
            make.top.equalTo(shopImageView.backgroundImageView.snp.bottom)
            make.leading.trailing.equalToSuperview().inset(1)
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
        
        // Add to view
        addBar(bar, dataSource: self, at: .custom(view: tapView, layout: nil))
    }
    
    @objc func buttonClicked() {
        print(#function)
    }
}

extension ShopViewController: PageboyViewControllerDataSource, TMBarDataSource {
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


