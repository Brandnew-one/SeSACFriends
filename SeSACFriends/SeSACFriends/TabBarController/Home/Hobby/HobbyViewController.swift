//
//  HobbyViewController.swift
//  SeSACFriends
//
//  Created by 신상원 on 2022/02/08.
//

import SnapKit
import UIKit

class HobbyViewController: UIViewController, ViewRepresentable {

    let collectionView = UICollectionView(frame: CGRect(), collectionViewLayout: UICollectionViewLayout())
    let testString = ["테스트입니다", "테스트", "중", "가나", "살려줘", "오잉", "너무 어려워", "왜3개?", "중", "중", "중", "중", "중", "중",]
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        let searchBar = UISearchBar()
        searchBar.placeholder = "띄어쓰기로 복수 입력이 가능해요"
        self.navigationItem.titleView = searchBar
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: ImageSet.backButton), style: .plain, target: self, action: #selector(backButtonClicked))
        self.navigationItem.leftBarButtonItem?.tintColor = UIColor(rgbString: ColorSet.black)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(MyHobbyCollectionViewCell.self, forCellWithReuseIdentifier: MyHobbyCollectionViewCell.identifier)
        
        setupView()
        setupConstraints()
        setFlowLayout()
    }
    
    @objc func backButtonClicked() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func setupView() {
        view.addSubview(collectionView)
    }
    
    func setupConstraints() {
        collectionView.snp.makeConstraints { make in
            make.top.bottom.equalTo(view.safeAreaLayoutGuide)
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
        layout.sectionInset = UIEdgeInsets(top: 12.0, left: spacing, bottom: 12.0, right: spacing)
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
        return 1
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
}
