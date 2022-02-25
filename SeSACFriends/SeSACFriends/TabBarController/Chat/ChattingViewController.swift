//
//  ChattingViewController.swift
//  SeSACFriends
//
//  Created by 신상원 on 2022/02/18.
//

import SnapKit
import Toast_Swift

import UIKit

class ChattingViewController: UIViewController, ViewRepresentable {
    
    var homeViewModel = HomeViewModel()
    var chattingModel = ChattingViewModel()
    
    var tableView = UITableView()
    var keyboardView = KeyboardView()
    var dummyData = ["신", "상원", "이무니다.", "개행하면 어쩔\n티비", "ㄹㅇㅋㅋ\nㅋㅋㄹㅃ\n뽕", "ㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋ"]
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.addKeyboardNotifications()
        navigationController?.navigationBar.isHidden = false
        self.tabBarController?.tabBar.isHidden = true
        
        homeViewModel.myQueueState.bind { _ in
            self.navigationItem.title = "\(self.homeViewModel.myQueueState.value.matchedNick!)"
            print(self.homeViewModel.myQueueState.value.matchedUid)
        }
        
        chattingModel.chatModel.bind { _ in
            self.tableView.reloadData()
        }
        SocketIOManager.shared.establishConnection()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.removeKeyboardNotifications()
        SocketIOManager.shared.closeConnection()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupConstraints()
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: ImageSet.backButton), style: .plain, target: self, action: #selector(backButtonClicked))
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: ImageSet.more), style: .plain, target: self, action: #selector(moreButtonClicked))
        self.navigationController?.navigationBar.tintColor = UIColor(rgbString: ColorSet.black)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 100
        tableView.separatorColor = .clear
        tableView.register(MyChatTableViewCell.self, forCellReuseIdentifier: MyChatTableViewCell.identifier)
        tableView.register(YourChatTableViewCell.self, forCellReuseIdentifier: YourChatTableViewCell.identifier)
        
        keyboardView.textView.delegate = self
        keyboardView.sendButton.addTarget(self, action: #selector(sendButtonClicked), for: .touchUpInside)
        chattingModel.fetchChatHistory(id: self.homeViewModel.myQueueState.value.matchedUid!, date: "2022-02-22T18:29:16.073Z") { code in
            if code == 200 {
                print("??되는건가요??")
            }
        }
        NotificationCenter.default.addObserver(self, selector: #selector(getMessage), name: NSNotification.Name("getMessage"), object: nil)
    }
    
    func setupView() {
        view.backgroundColor = .white
        [tableView, keyboardView].forEach {
            view.addSubview($0)
        }
    }
    
    func setupConstraints() {
        keyboardView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-16)
            make.height.equalTo(52)
        }
        tableView.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalTo(keyboardView.snp.top)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true) // 이렇게 해줘야 내려간다!
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
    
    @objc func sendButtonClicked() {
        let chat = keyboardView.textView.text
        keyboardView.textView.text.removeAll()
        keyboardView.sendButton.setImage(UIImage(named: ImageSet.send), for: .normal)
        chattingModel.sendChatting(id: homeViewModel.myQueueState.value.matchedUid!, chat: chat!) { code in
            if code == StatusCode.successCase1 {
                self.view.makeToast("약속이 종료되어 채팅을 보낼 수 없습니다")
            } else if code == StatusCode.success {
                self.chattingModel.fetchChatHistory(id: self.homeViewModel.myQueueState.value.matchedUid!, date: "2022-02-22T18:29:16.073Z") { code in
                    if code == StatusCode.success {
                        print("??되는건가요??")
                    }
                }
            }
        }
    }
    
    @objc func getMessage(notification: NSNotification) {
        print("112233")
        let chat = notification.userInfo!["chat"] as! String
        let from = notification.userInfo!["from"] as! String
        let to = notification.userInfo!["to"] as! String
        let createdAt = notification.userInfo!["createdAt"] as! String
        let v = notification.userInfo!["__v"] as! Int
        let id = notification.userInfo!["_id"] as! String
        
        var value = Payload(id: id, v: v, to: to, from: from, chat: chat, createdAt: createdAt)
        
        chattingModel.chatModel.value.payload.append(value)
        self.tableView.reloadData()
    }
    
}

extension ChattingViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return chattingModel.chatModel.value.payload.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if chattingModel.chatModel.value.payload[indexPath.section].from != homeViewModel.myQueueState.value.matchedUid {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: YourChatTableViewCell.identifier, for: indexPath) as? YourChatTableViewCell else {
                return UITableViewCell()
            }
            cell.label.text = chattingModel.chatModel.value.payload[indexPath.section].chat
            cell.timeLabel.text = chattingModel.chatModel.value.payload[indexPath.section].createdAt
            cell.selectionStyle = .none
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: MyChatTableViewCell.identifier, for: indexPath) as? MyChatTableViewCell else {
                return UITableViewCell()
            }
            cell.label.text = chattingModel.chatModel.value.payload[indexPath.section].chat
            cell.timeLabel.text = chattingModel.chatModel.value.payload[indexPath.section].createdAt
            cell.selectionStyle = .none
            return cell
        }
    }
    
    // cell 간격 조절을 위해서 (inset이 적용되지 않음) -> but heightForHeaderInSection 으로 높이가 조절되지 않음
   func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
       let headerView = UIView()
       headerView.backgroundColor = UIColor.clear
       return headerView
   }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        view.endEditing(true)
    }
    
    // Set the spacing between sections
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }

    
}

extension ChattingViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        print(textView.text)
        if textView.text.isEmpty {
            keyboardView.sendButton.setImage(UIImage(named: ImageSet.send), for: .normal)
        } else if textView.text == "" {
            keyboardView.sendButton.setImage(UIImage(named: ImageSet.send), for: .normal)
        } else {
            keyboardView.sendButton.setImage(UIImage(named: ImageSet.sendGreen), for: .normal)
        }
    }
}
