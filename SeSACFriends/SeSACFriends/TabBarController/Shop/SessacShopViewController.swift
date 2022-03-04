//
//  SessacShopViewController.swift
//  SeSACFriends
//
//  Created by 신상원 on 2022/03/03.
//

import UIKit
import SnapKit

class SessacShopViewController: UIViewController, ViewRepresentable {
    
    let emptyImageView = UIView()
    let emptyTapView = UIView()
    let collectionView = UICollectionView(frame: CGRect(), collectionViewLayout: UICollectionViewLayout())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupConstraints()
    }
    
    func setupView() {
        [emptyImageView, emptyTapView, collectionView].forEach {
            view.addSubview($0)
        }
        emptyImageView.backgroundColor = .clear
        emptyTapView.backgroundColor = .clear
    }
    
    func setupConstraints() {
        emptyImageView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(15)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(14)
            make.trailing.equalTo(view.safeAreaLayoutGuide).offset(-12.8)
            make.height.equalTo(174.61)
        }
        
        emptyTapView.snp.makeConstraints { make in
            make.top.equalTo(emptyImageView.snp.bottom)
            make.leading.trailing.equalToSuperview().inset(1)
            make.height.equalTo(44)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(emptyTapView.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
    
}
