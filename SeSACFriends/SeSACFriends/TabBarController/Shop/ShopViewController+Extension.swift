//
//  ShopViewController+Extension.swift
//  SeSACFriends
//
//  Created by 신상원 on 2022/03/04.
//

import UIKit
import Toast_Swift

// MARK: Background TableView Delegate
extension ShopViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shopViewModel.backgroundTitles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: BackgroundTableViewCell.identifier, for: indexPath) as? BackgroundTableViewCell else {
            return UITableViewCell()
        }
        let row = indexPath.row
        cell.backgroundImageView.image = setBackgroundImage(background: row)
        cell.contentLabel.text = shopViewModel.backgroundContents[row]
        cell.titleLabel.text = shopViewModel.backgroundTitles[row]
        if setBackgroundPriceButton(index: row) {
            cell.priceButton.setTitle("보유", for: .normal)
            cell.priceButton.setupMode(mode: .cancel)
        } else {
            cell.priceButton.setTitle(shopViewModel.backgroundPrice[row], for: .normal)
            cell.priceButton.setupMode(mode: .fill)
        }
        cell.priceButton.tag = row
        cell.priceButton.addTarget(self, action: #selector(priceButtonClicked(sender:)), for: .touchUpInside)
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 190
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        shopImageView.backgroundImageView.image = setBackgroundImage(background: indexPath.row)
    }
    
    @objc func priceButtonClicked(sender: UIButton) {
        print(#function)
//        shopImageView.backgroundImageView.image = setBackgroundImage(background: sender.tag)
        shopViewModel.fetchpurchaseItem(mode: .background, itemIndex: sender.tag) { code in
            if code == 201 {
                self.view.makeToast("이미 보유한 아이템입니다.")
            } else if code == 200 {
                self.view.makeToast("아이템 구매 성공.")
                self.shopViewModel.fetchMyShopInfo { code in
                    if code == 200 {
                        self.backgroundVC.tableView.reloadData()
                    }
                }
            }
        }
    }
    
    // 이미 결제된 상품인지 확인하는 메서드
    func setBackgroundPriceButton(index: Int) -> Bool {
        if shopViewModel.myShopInfo.value.backgroundCollection.contains(index) {
            return true
        } else {
            return false
        }
    }
}

// MARK: Sesac CollectionView Delegate
extension ShopViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return shopViewModel.sesacTitles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SessacShopCollectionViewCell.identifier, for: indexPath) as? SessacShopCollectionViewCell else {
            return UICollectionViewCell()
        }
        let row = indexPath.item
        cell.sesacImageView.image = setSesacFaceImage(sesac: row)
        cell.titleLabel.text = shopViewModel.sesacTitles[row]
        cell.contentLabel.text = shopViewModel.sesacContents[row]
        if setSesacPriceButton(index: row) {
            cell.priceButton.setTitle("보유", for: .normal)
            cell.priceButton.setupMode(mode: .cancel)
            cell.priceButton.isEnabled = false
        } else {
            cell.priceButton.setTitle(shopViewModel.sesacPrice[row], for: .normal)
            cell.priceButton.isEnabled = true
        }
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        shopImageView.sesacImageView.image = setSesacFaceImage(sesac: indexPath.item)
    }
    
    @objc func sessacPriceButtonClicked(sender: UIButton) {
        print(#function)
        shopViewModel.fetchpurchaseItem(mode: .sessac, itemIndex: sender.tag) { code in
            if code == 201 {
                self.view.makeToast("이미 보유한 아이템입니다.")
            } else if code == 200 {
                self.view.makeToast("아이템 구매 성공.")
                self.shopViewModel.fetchMyShopInfo { code in
                    if code == 200 {
                        self.sesacVC.collectionView.reloadData()
                    }
                }
            }
        }
    }
    
    // 이미 결제된 상품인지 확인하는 메서드
    func setSesacPriceButton(index: Int) -> Bool {
        if shopViewModel.myShopInfo.value.sesacCollection.contains(index) {
            return true
        } else {
            return false
        }
    }
    
}
