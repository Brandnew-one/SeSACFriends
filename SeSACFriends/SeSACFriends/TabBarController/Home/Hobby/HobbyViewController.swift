//
//  HobbyViewController.swift
//  SeSACFriends
//
//  Created by 신상원 on 2022/02/08.
//

import SnapKit
import UIKit

class HobbyViewController: UIViewController, ViewRepresentable {
    
    let findButton = MyButton(frame: CGRect(), mode: .fill, text: "새싹찾기")
    let collectionView = UICollectionView(frame: CGRect(), collectionViewLayout: UICollectionViewLayout())
    let testString = ["테스트입니다", "테스트", "중", "가나", "살려줘", "오잉", "너무 어려워", "왜3개?"]
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false
        self.tabBarController?.tabBar.isHidden = true
        self.tabBarController?.tabBar.isTranslucent = true
        addKeyboardNotifications()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        removeKeyboardNotifications()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        let searchBar = UISearchBar()
        searchBar.placeholder = "띄어쓰기로 복수 입력이 가능해요"
        self.navigationItem.titleView = searchBar
        searchBar.searchTextField.delegate = self
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: ImageSet.backButton), style: .plain, target: self, action: #selector(backButtonClicked))
        self.navigationItem.leftBarButtonItem?.tintColor = UIColor(rgbString: ColorSet.black)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(HobbyCustomHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HobbyCustomHeaderView.identifier)
        collectionView.register(MyHobbyCollectionViewCell.self, forCellWithReuseIdentifier: MyHobbyCollectionViewCell.identifier)
        
        setupView()
        setupConstraints()
        setFlowLayout()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print(#function)
//        view.endEditing(true)
        navigationItem.titleView?.endEditing(true) // 이렇게 해줘야 내려간다!
    }
    
    @objc func backButtonClicked() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func setupView() {
        view.addSubview(collectionView)
        view.addSubview(findButton)
    }
    
    func setupConstraints() {
        
        findButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-16)
            make.height.equalTo(48)
        }
        
        collectionView.snp.makeConstraints { make in
            make.bottom.equalTo(findButton.snp.top).offset(-20)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(32)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
    }
    
    func setFlowLayout() {
        let layout = LeftAlignedCollectionViewFlowLayout()
        let spacing: CGFloat = 8
        let width = 32.0
        let height = 32.0
//        layout.itemSize = CGSize(width: width, height: height)
        layout.sectionInset = UIEdgeInsets(top: 12.0, left: 0.0, bottom: 12.0, right: spacing)
        layout.minimumInteritemSpacing = spacing
        layout.minimumLineSpacing = spacing
        layout.estimatedItemSize = CGSize(width: width, height: height)
        layout.scrollDirection = .vertical
        collectionView.collectionViewLayout = layout
    }
    
    
}

extension HobbyViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return testString.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MyHobbyCollectionViewCell.identifier, for: indexPath) as? MyHobbyCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        cell.cellLabel.text = testString[indexPath.item]
        
        return cell
    }
    
    
}

extension HobbyViewController: UICollectionViewDelegateFlowLayout {
    
    // viewModel에 넣어줄 텍스트가 저장되어 있다면 미리 사이즈를 알 수 있음
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellView = UIView()
        let cellLabel = UILabel()
        let cellImageView = UIImageView()
        
        [cellLabel, cellImageView].forEach {
            cellView.addSubview($0)
        }
        
        cellLabel.font = FontSet.title4R14
        cellLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-36)
            make.top.equalToSuperview().offset(5)
            make.bottom.equalToSuperview().offset(-5)
        }
        
        cellImageView.snp.makeConstraints { make in
            make.leading.equalTo(cellLabel.snp.trailing).offset(4)
            make.centerY.equalTo(cellLabel)
            make.height.width.equalTo(16)
        }
        
        cellLabel.text = testString[indexPath.item]
        let size = cellView.frame.size
        
        return CGSize(width: size.width, height: 32.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HobbyCustomHeaderView.identifier, for: indexPath) as? HobbyCustomHeaderView else {
            return UICollectionReusableView()
        }
        if indexPath.section == 0 {
            headerView.headerLabel.text = "지금 주변에는"
        } else {
            headerView.headerLabel.text = "내가 하고싶은"
        }
//        headerView.backgroundColor = .red
        return headerView
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: self.collectionView.frame.width, height: 18)
    }
    
}

extension HobbyViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        //view.endEditing 메서드로는 왜 키보드가 내려가지 않을까? (willHide, willShow 를 만들어놔서?)
        textField.resignFirstResponder()
        return true
    }
}
