//
//  ShopViewController+Extension.swift
//  SeSACFriends
//
//  Created by 신상원 on 2022/03/04.
//

import UIKit

// MARK: Background TableView Delegate
extension ShopViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return backgroundTitles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: BackgroundTableViewCell.identifier, for: indexPath) as? BackgroundTableViewCell else {
            return UITableViewCell()
        }
        let row = indexPath.row
        cell.backgroundImageView.image = setBackgroundImage(background: row)
        cell.contentLabel.text = backgroundContents[row]
        cell.titleLabel.text = backgroundTitles[row]
        cell.priceButton.tag = row
        cell.priceButton.addTarget(self, action: #selector(priceButtonClicked(sender:)), for: .touchUpInside)
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 190
    }
    
    @objc func priceButtonClicked(sender: UIButton) {
        shopImageView.backgroundImageView.image = setBackgroundImage(background: sender.tag)
    }
    
}

// MARK: Sesac CollectionView Delegate
extension ShopViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sesacTitles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SessacShopCollectionViewCell.identifier, for: indexPath) as? SessacShopCollectionViewCell else {
            return UICollectionViewCell()
        }
        let row = indexPath.item
        cell.sesacImageView.image = setSesacFaceImage(sesac: row)
        cell.titleLabel.text = sesacTitles[row]
        cell.contentLabel.text = sesacContents[row]
        cell.priceButton.tag = row
        cell.priceButton.addTarget(self, action: #selector(sessacPriceButtonClicked(sender:)), for: .touchUpInside)
        return cell
    }
    
    func setFlowLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        let spacing: CGFloat = 16
        let width = UIScreen.main.bounds.width - 12
        let height = 285.0
        layout.itemSize = CGSize(width: width / 2, height: height)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 6)
        layout.minimumInteritemSpacing = 1
        layout.minimumLineSpacing = spacing
        layout.scrollDirection = .vertical
        return layout
    }
    
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        shopImageView.sesacImageView.image = setSesacFaceImage(sesac: indexPath.item)
//    }
    
    @objc func sessacPriceButtonClicked(sender: UIButton) {
        shopImageView.sesacImageView.image = setSesacFaceImage(sesac: sender.tag)
    }
    
}
