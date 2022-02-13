//
//  HobbyViewController.swift
//  SeSACFriends
//
//  Created by 신상원 on 2022/02/08.
//

import SnapKit
import Toast_Swift

import CoreLocation
import UIKit

class HobbyViewController: UIViewController, ViewRepresentable {
    
    let findButton = MyButton(frame: CGRect(), mode: .fill, text: "새싹찾기")
    let collectionView = UICollectionView(frame: CGRect(), collectionViewLayout: UICollectionViewLayout())
    let homeViewModel = HomeViewModel()
    let hobbyViewModel = HobbyViewModel()
    var location: CLLocationCoordinate2D = CLLocationCoordinate2D()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false
        self.tabBarController?.tabBar.isHidden = true
        self.tabBarController?.tabBar.isTranslucent = true
        addKeyboardNotifications()
        homeViewModel.fetchSearchFriends(location: location) {
            self.homeViewModel.updatehfArray()
//            print(self.homeViewModel.hfArray)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        removeKeyboardNotifications()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupConstraints()
        setFlowLayout()
        
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
        collectionView.register(ServerHobbyCollectionViewCell.self, forCellWithReuseIdentifier: ServerHobbyCollectionViewCell.identifier)
        collectionView.register(OtherHobbyCollectionViewCell.self, forCellWithReuseIdentifier: OtherHobbyCollectionViewCell.identifier)
        // 처음 뷰 들어올 때, API 통신을 통해서 컬렉션 뷰 리로드
        homeViewModel.result.bind { result in
            self.collectionView.reloadData()
        }
        
        // 사용자가 취미를 등록할 때, 컬렉션 뷰 릴로드
        hobbyViewModel.form.bind { result in
            self.collectionView.reloadData()
        }
        
        findButton.addTarget(self, action: #selector(findButtonClicked), for: .touchUpInside)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        navigationItem.titleView?.endEditing(true) // 이렇게 해줘야 내려간다!
    }
    
    @objc func findButtonClicked() {
        print(#function)
        print(hobbyViewModel.form.value)
        hobbyViewModel.form.value.long = location.longitude
        hobbyViewModel.form.value.lat = location.latitude
        hobbyViewModel.form.value.region = APIService.findRegion(Location: location)
        hobbyViewModel.fetchHobbyFriends {
            let vc = TabmanSearchViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @objc func backButtonClicked() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func setupView() {
        view.backgroundColor = .white
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
    
    // 1) 8개가 넘지 않는가?
    // 2) 1~8 글자 조건을 만족하는가?
    // 3) 이미 중복되는 취미가 있는가?
    func checkCell(str: String) -> Bool {
        if hobbyViewModel.form.value.hf.count >= 8 {
            self.view.makeToast("취미를 더 이상 추가할 수 없습니다")
            return false
        }
        // 2)
        if str.count < 1 || str.count > 8 {
            self.view.makeToast("최소 한 자 이상, 최대 8글자까지 작성 가능합니다")
            return false
        }
        // 3)
        if hobbyViewModel.form.value.hf.contains(str) {
            self.view.makeToast("이미 등록된 취미입니다.")
            return false
        }
        return true
    }
    
    
}

extension HobbyViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return homeViewModel.hfArray.count
        } else {
            return hobbyViewModel.form.value.hf.count
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            if indexPath.item <= homeViewModel.recommendIndex {
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ServerHobbyCollectionViewCell.identifier, for: indexPath) as? ServerHobbyCollectionViewCell else {
                    return UICollectionViewCell()
                }
                cell.cellLabel.text = homeViewModel.hfArray[indexPath.item]
                return cell
            } else {
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OtherHobbyCollectionViewCell.identifier, for: indexPath) as? OtherHobbyCollectionViewCell else {
                    return UICollectionViewCell()
                }
                cell.cellLabel.text = homeViewModel.hfArray[indexPath.item]
                return cell
            }
        } else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MyHobbyCollectionViewCell.identifier, for: indexPath) as? MyHobbyCollectionViewCell else {
                return UICollectionViewCell()
            }
            cell.cellLabel.text = hobbyViewModel.form.value.hf[indexPath.row]
            return cell
        }
    }
    
    
}

extension HobbyViewController: UICollectionViewDelegateFlowLayout {
    
    // viewModel에 넣어줄 텍스트가 저장되어 있다면 미리 사이즈를 알 수 있음
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // 서버에서 추천 & 주변 취미들을 위한 사이즈
        if indexPath.section == 0 {
            let cellView = UIView()
            let cellLabel = UILabel()
            
            [cellLabel].forEach {
                cellView.addSubview($0)
            }
            
            cellLabel.font = FontSet.title4R14
            cellLabel.snp.makeConstraints { make in
                make.leading.equalToSuperview().offset(16)
                make.trailing.equalToSuperview().offset(-16)
                make.top.equalToSuperview().offset(5)
                make.bottom.equalToSuperview().offset(-5)
            }
            cellLabel.text = homeViewModel.hfArray[indexPath.item]
            let size = cellView.frame.size
            return CGSize(width: size.width, height: 32.0)
        // 내가 추가한 취미들을 위한 사이즈
        } else {
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
//            cellLabel.text = testString[indexPath.item]
            cellLabel.text = hobbyViewModel.form.value.hf[indexPath.item]
            let size = cellView.frame.size
            return CGSize(width: size.width, height: 32.0)
        }
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
        return headerView
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: self.collectionView.frame.width, height: 18)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // 추가하는 경우
        if indexPath.section == 0 {
            if indexPath.item <= homeViewModel.recommendIndex {
                guard let cell = collectionView.cellForItem(at: indexPath) as? ServerHobbyCollectionViewCell, let text = cell.cellLabel.text else { return }
                if checkCell(str: text) {
                    hobbyViewModel.form.value.hf.append(text)
                }
            } else {
                guard let cell = collectionView.cellForItem(at: indexPath) as? OtherHobbyCollectionViewCell, let text = cell.cellLabel.text else { return }
                if checkCell(str: text) {
                    hobbyViewModel.form.value.hf.append(text)
                }
            }
        } else { // 내가 선택한 취미에서 삭제하는 경우
            hobbyViewModel.form.value.hf.remove(at: indexPath.item)
        }
    }
    
}

extension HobbyViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        var text = textField.text ?? "" // 텍스트 필드에 입력된 값
        var result = text.components(separatedBy: " ") // 공백을 기준으로 나눈 값들
        
        for str in result {
            if !checkCell(str: str) {
                break
            } else {
                hobbyViewModel.form.value.hf.append(str)
            }
        }
        return true
    }
    
}
