//
//  RequestViewController.swift
//  SeSACFriends
//
//  Created by 신상원 on 2022/02/13.
//


import CoreLocation
import UIKit

import SnapKit
import Toast_Swift

class RequestViewController: UIViewController, ViewRepresentable {
    
    let emptyView = EmptyView()
    let tableView = UITableView()
    var location: CLLocationCoordinate2D = CLLocationCoordinate2D()
    let homeViewModel = HomeViewModel()
    var timer: DispatchSourceTimer?
    var remainingTime: Int = 5
    private var refreshControl = UIRefreshControl()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        homeViewModel.fetchSearchFriends(location: location) {
            self.homeViewModel.result.bind {_ in
                self.tableView.reloadData()
            }
        }
        startTimer()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupConstraints()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = false
        tableView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(pullRefresh), for: .valueChanged)
        refreshControl.attributedTitle = NSAttributedString(string: "새로고침 중이에요!")
        tableView.register(SesacTableViewCell.self, forCellReuseIdentifier: SesacTableViewCell.identifier)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 120
        tableView.separatorInset.top = 10.0
        tableView.separatorInset.bottom = 10.0
        
        emptyView.myButton.addTarget(self, action: #selector(changeHobbyButtonClicked), for: .touchUpInside)
        emptyView.refreshButton.addTarget(self, action: #selector(refreshButtonClicked), for: .touchUpInside)
    }
    
    func setupView() {
        view.backgroundColor = .white
        view.addSubview(tableView)
        
        emptyView.noneView.titleLabel.text = "아직 받은 요청이 없어요ㅠ"
        emptyView.noneView.contentLabel.text = "취미를 변경하거나 조금만 더 기다려 주세요!"
        tableView.addSubview(emptyView)
    }
    
    func setupConstraints() {
        tableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(44)
            make.leading.equalToSuperview().offset(16)
            make.trailing.bottom.equalToSuperview().offset(-16)
        }
                
        emptyView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(44)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(16)
            make.trailing.bottom.equalTo(view.safeAreaLayoutGuide).offset(-16)
        }
    }
    
    func checkQueueState(mode: QueueStateMode) {
        self.homeViewModel.fetchMyQueueState { code in
            if code == StatusCode.successCase1 {
                UserDefaults.standard.set(0, forKey: UserDefautlsSet.state)
            } else if code == StatusCode.success {
                if self.homeViewModel.myQueueState.value.matched == 0 {
                    UserDefaults.standard.set(1, forKey: UserDefautlsSet.state)
                } else if self.homeViewModel.myQueueState.value.matched == 1 {
                    UserDefaults.standard.set(2, forKey: UserDefautlsSet.state)
                    if mode == .fiveSecondsQueue {
                        self.view.makeToast("\(self.homeViewModel.myQueueState.value.matchedNick!)님과 매칭되셨습니다. 잠시 후 채팅방으로 이동합니다", duration: 1, position: .bottom, style: ToastManager.shared.style) { didTap in
                            self.changeViewChatting()
                        }
                    } else if mode == .requestQueue {
                        self.view.makeToast("상대방도 취미 함께 하기 요청을 했습니다. 채팅방으로 이동합니다", duration: 1, position: .bottom, style: ToastManager.shared.style) { didTap in
                            self.changeViewChatting()
                        }
                    } else {
                        self.view.makeToast("채팅방으로 이동합니다", duration: 1, position: .bottom, style: ToastManager.shared.style) { didTap in
                            self.changeViewChatting()
                        }
                    }
                }
            }
        }
    }
    
    func changeViewChatting() {
        let vc = ChattingViewController()
        vc.homeViewModel = self.homeViewModel
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    //Start & Reset
    func startTimer() {
        //타이머가 처음 동작하는 경우
        if self.timer == nil {
            self.timer = DispatchSource.makeTimerSource(flags: [], queue: .main)
            //1초 간격으로 아래의 event 가 발생한다고 생각
            self.timer?.schedule(deadline: .now(), repeating: 1)
            self.timer?.setEventHandler(handler: { [weak self] in
                guard let self = self else { return }
                self.remainingTime -= 1
                
                //지정된 시간이 모두 흐른경우
                if self.remainingTime <= 0 {
                    self.stopTimer()
//                    print("------------------5S-------------------")
                    self.checkQueueState(mode: .fiveSecondsQueue)
                    self.remainingTime = 5
                    self.startTimer()
                }
            })
            self.timer?.resume()
        } else { // 인증번호를 다시 받는 경우
            self.stopTimer()
            self.remainingTime = 5
            self.startTimer()
        }
    }
    
    func stopTimer() {
        self.timer?.cancel()
        self.timer = nil //nil 로 메모리 해제 필요!
    }
    
    @objc func changeHobbyButtonClicked() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func refreshButtonClicked() {
        self.homeViewModel.fetchSearchFriends(location: self.location) {
            self.tableView.reloadData()
        }
    }
    
    @objc func pullRefresh() {
        DispatchQueue.main.async {
            self.homeViewModel.fetchSearchFriends(location: self.location) {
                self.tableView.reloadData()
                self.refreshControl.endRefreshing()
            }
        }
    }
    
}

extension RequestViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if homeViewModel.result.value.fromQueueDBRequested.isEmpty {
            self.emptyView.isHidden = false
        } else {
            self.emptyView.isHidden = true
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
        checkQueueState(mode: .acceptQueue)
        vc.modalPresentationStyle = .overCurrentContext
        vc.modalTransitionStyle = .crossDissolve
        vc.homeviewModel = self.homeViewModel
        vc.index = sender.tag
        vc.mode = .accept
        
        vc.completion = { code in
            if code == StatusCode.success {
                self.view.makeToast("취미함께 요청하기를 보냈습니다")
            } else if code == StatusCode.successCase1 {
                self.view.makeToast("상대방이 이미 다른 사람과 취미를 함께하는 중입니다.")
            } else if code == StatusCode.successCase2 {
                self.view.makeToast("상대방이 취미 함께 하기를 그만두었습니다")
            } else if code == StatusCode.successCase3 {
                self.view.makeToast("앗! 누군가가 나의 취미 함께 하기를 수락하였어요!")
                print("onQueue/State 필요")
            }
        }
        self.present(vc, animated: true, completion: nil)
    }
    
}



