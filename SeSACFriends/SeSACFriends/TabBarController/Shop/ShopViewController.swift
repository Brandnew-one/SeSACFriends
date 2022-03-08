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
import Toast_Swift

class ShopViewController: TabmanViewController, ViewRepresentable {
    
    private var viewControllers: Array<UIViewController> = []
    var shopViewModel = ShopImageViewModel()
    var tapView = UIView()
    var shopImageView = ShopImageView()
    let sesacVC = SessacShopViewController()
    let backgroundVC = BackgroundShopViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupConstraints()
        
        self.navigationItem.title = "새싹샵"
//        let sesacVC = SessacShopViewController()
//        let backgroundVC = BackgroundShopViewController()
        viewControllers.append(sesacVC)
        viewControllers.append(backgroundVC)
        
        self.dataSource = self
        createBar()
        shopImageView.button.addTarget(self, action: #selector(buttonClicked), for: .touchUpInside)
        
        backgroundVC.tableView.delegate = self
        backgroundVC.tableView.dataSource = self
        backgroundVC.tableView.separatorColor = .clear
        backgroundVC.tableView.register(BackgroundTableViewCell.self, forCellReuseIdentifier: BackgroundTableViewCell.identifier)
        
        sesacVC.collectionView.delegate = self
        sesacVC.collectionView.dataSource = self
        sesacVC.collectionView.register(SessacShopCollectionViewCell.self, forCellWithReuseIdentifier: SessacShopCollectionViewCell.identifier)
        sesacVC.collectionView.collectionViewLayout = setFlowLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false
        self.tabBarController?.tabBar.isHidden = false
        
        shopViewModel.fetchMyShopInfo { code in
            if code == StatusCode.success {
                print("Fetch ShopInfo Success")
                self.setupImage()
            }
        }
        // 보유중인 상품이 먼저 viewDidLoad 에서 수정되지 않게 하기 위해서
        shopViewModel.myShopInfo.bind { _ in
            self.sesacVC.collectionView.reloadData()
            self.backgroundVC.tableView.reloadData()
        }
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
    
    func setupImage() {
        shopImageView.backgroundImageView.image = setBackgroundImage(background: shopViewModel.myShopInfo.value.background)
        shopImageView.sesacImageView.image = setSesacFaceImage(sesac: shopViewModel.myShopInfo.value.sesac)
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
        var sesac = getIntfromSesacImage(image: shopImageView.sesacImageView.image!)
        var background = getIntfromBackgroundImage(image: shopImageView.backgroundImageView.image!)
        shopViewModel.fetchUpdateShop(sesac: sesac, background: background) { code in
            if code == 201 {
                self.view.makeToast("구매가 필요한 아이템이 있어요!")
            } else if code == 200 {
                self.view.makeToast("업데이트 성공")
            }
        }
    }
}

extension ShopViewController: PageboyViewControllerDataSource, TMBarDataSource {
    
    func barItem(for bar: TMBar, at index: Int) -> TMBarItemable {
        let item = TMBarItem(title: "")
        item.title = shopViewModel.vcName[index]
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
