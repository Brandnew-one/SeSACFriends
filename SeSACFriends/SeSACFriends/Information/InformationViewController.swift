//
//  InformationViewController.swift
//  SeSACFriends
//
//  Created by 신상원 on 2022/01/26.
//

import SnapKit
import UIKit

class InformationViewController: UIViewController, ViewRepresentable {
   
    var tableView = UITableView()
    
    let images: [UIImage?] = [
        UIImage(named: "notice") ?? UIImage(systemName: "star"),
        UIImage(named: "faq") ?? UIImage(systemName: "star"),
        UIImage(named: "qna") ?? UIImage(systemName: "star"),
        UIImage(named: "setting_alarm") ?? UIImage(systemName: "star"),
        UIImage(named: "permit") ?? UIImage(systemName: "star")
    ]
    let titles = ["공지사항", "자주 묻는 질문", "1:1 문의", "알림 설정", "이용 약관"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.title = "내 정보"
        setupView()
        setupConstraints()
    }
    
    func setupView() {
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.isScrollEnabled = false
        tableView.register(InformationTableViewCell.self, forCellReuseIdentifier: InformationTableViewCell.identifier)
        tableView.register(InformationHeaderViewCell.self, forCellReuseIdentifier: InformationHeaderViewCell.identifier)
    }
    
    func setupConstraints() {
        tableView.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
}


extension InformationViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return titles.count + 1
        } else {
            return 0
        }
    }


    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: InformationHeaderViewCell.identifier, for: indexPath) as? InformationHeaderViewCell else {
                return UITableViewCell()
            }
            cell.titleLable.text = "신상원"
            return cell

        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: InformationTableViewCell.identifier, for: indexPath) as? InformationTableViewCell else {
                return UITableViewCell()
            }
            let row = indexPath.row - 1
            cell.imagesView.image = images[row]
            cell.titleLabel.text = titles[row]
            return cell
        }
    }


    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 96
        } else { return 74 }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 && indexPath.section == 0 {
            let vc = MyInformationViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }

}
