//
//  ChattingViewController.swift
//  SeSACFriends
//
//  Created by 신상원 on 2022/02/18.
//

import SnapKit
import UIKit

class ChattingViewController: UIViewController, ViewRepresentable {
    
    var homeViewModel = HomeViewModel()
    var tableView = UITableView()
    var dummyData = ["신", "상원", "이무니다.", "개행하면 어쩔\n티비", "ㄹㅇㅋㅋ\nㅋㅋㄹㅃ\n뽕"]
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false
        self.tabBarController?.tabBar.isHidden = true
        homeViewModel.myQueueState.bind { _ in
            self.navigationItem.title = "\(self.homeViewModel.myQueueState.value.matchedNick!)"
            print(self.homeViewModel.myQueueState.value.matchedUid)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupConstraints()
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: ImageSet.backButton), style: .plain, target: self, action: #selector(backButtonClicked))
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: ImageSet.more), style: .plain, target: self, action: #selector(moreButtonClicked))
        
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 100
        tableView.separatorColor = .clear
        tableView.register(MyChatTableViewCell.self, forCellReuseIdentifier: MyChatTableViewCell.identifier)
        tableView.register(YourChatTableViewCell.self, forCellReuseIdentifier: YourChatTableViewCell.identifier)
    }
    
    func setupView() {
        view.backgroundColor = .white
        view.addSubview(tableView)
    }
    
    func setupConstraints() {
        tableView.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    @objc func backButtonClicked() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func moreButtonClicked() {
        let vc = MoreViewController()
        vc.modalPresentationStyle = .overCurrentContext
        vc.modalTransitionStyle = .crossDissolve
        vc.homeViewModel = self.homeViewModel
        self.present(vc, animated: true, completion: nil)
    }
    
}

extension ChattingViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return dummyData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section % 2 == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: MyChatTableViewCell.identifier, for: indexPath) as? MyChatTableViewCell else {
                return UITableViewCell()
            }
            cell.label.text = dummyData[indexPath.section]
            cell.timeLabel.text = "15:41"
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: YourChatTableViewCell.identifier, for: indexPath) as? YourChatTableViewCell else {
                return UITableViewCell()
            }
            cell.label.text = dummyData[indexPath.section]
            cell.timeLabel.text = "16:41"
            return cell
        }
    }
    
    // cell 간격 조절을 위해서 (inset이 적용되지 않음) -> but heightForHeaderInSection 으로 높이가 조절되지 않음
   func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
       let headerView = UIView()
       headerView.backgroundColor = UIColor.clear
       return headerView
   }
    
    // Set the spacing between sections
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }

    
}
