//
//  RequestViewController.swift
//  SeSACFriends
//
//  Created by 신상원 on 2022/02/13.
//

import SnapKit

import CoreLocation
import UIKit

class RequestViewController: UIViewController, ViewRepresentable {
    
    let noneView = NoneView()
    let tableView = UITableView()
    var location: CLLocationCoordinate2D = CLLocationCoordinate2D()
    let homeViewModel = HomeViewModel()
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        homeViewModel.fetchSearchFriends(location: location) {
            self.homeViewModel.result.bind {_ in
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupConstraints()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = false
        tableView.register(SesacTableViewCell.self, forCellReuseIdentifier: SesacTableViewCell.identifier)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 120
        tableView.separatorInset.top = 10.0
        tableView.separatorInset.bottom = 10.0
    }
    
    func setupView() {
        view.backgroundColor = .white
        view.addSubview(tableView)
        
        noneView.titleLabel.text = "아직 받은 요청이 없어요ㅠ"
        noneView.contentLabel.text = "취미를 변경하거나 조금만 더 기다려 주세요!"
        tableView.addSubview(noneView)
    }
    
    func setupConstraints() {
        tableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(44)
            make.leading.equalToSuperview().offset(16)
            make.trailing.bottom.equalToSuperview().offset(-16)
        }
        
        noneView.snp.makeConstraints { make in
            make.centerY.equalTo(view.safeAreaLayoutGuide).offset(-24)
            make.leading.equalToSuperview().offset(46)
            make.trailing.equalToSuperview().offset(-46)
            make.height.equalTo(158)
        }
    }
    
    
}

extension RequestViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if homeViewModel.result.value.fromQueueDBRequested.isEmpty {
            self.noneView.isHidden = false
        } else {
            self.noneView.isHidden = true
        }
        return homeViewModel.result.value.fromQueueDBRequested.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
     // cell 간격 조절을 위해서 (inset이 적용되지 않음) -> but heightForHeaderInSection 으로 높이가 조절되지 않음
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.clear
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SesacTableViewCell.identifier, for: indexPath) as? SesacTableViewCell else {
            return UITableViewCell()
        }
        
        cell.cardView.backgroundImageView.image = setBackgroundImage(background: homeViewModel.result.value.fromQueueDBRequested[indexPath.section].background)
        cell.cardView.sesacImageView.image = setSesacFaceImage(sesac: homeViewModel.result.value.fromQueueDBRequested[indexPath.section].sesac)
  
        //ViewModel 에 넣어서 코드 줄이기!
        cell.cardView.nameView.nameLabel.text = homeViewModel.result.value.fromQueueDBRequested[indexPath.section].nick
        var index = 0
        for rep in homeViewModel.result.value.fromQueueDBRequested[indexPath.section].reputation {
            if index >= 6 {
                break
            }
            if rep > 0 {
                cell.cardView.titleView.cellTitles[index].setupMode(isOn: true)
            }
            index += 1
        }
        
        cell.cardView.reviewView.setupMode(review: homeViewModel.result.value.fromQueueDBRequested[indexPath.section].reviews.first)
        
        cell.button.backgroundColor = UIColor(rgbString: ColorSet.successColor)
        cell.button.setTitle("수락하기", for: .normal)
        cell.button.tag = indexPath.section
        cell.button.addTarget(self, action: #selector(sendButtonClicked(sender:)), for: .touchUpInside)
        
        return cell
    }
    
    @objc func sendButtonClicked(sender: UIButton) {
        print(#function)
        let vc = PopupViewController()
        vc.modalPresentationStyle = .overCurrentContext
        vc.modalTransitionStyle = .crossDissolve
        vc.mode = .accept
        self.present(vc, animated: true, completion: nil)
    }
    
}



