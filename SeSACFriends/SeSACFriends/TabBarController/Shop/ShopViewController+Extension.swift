//
//  ShopViewController+Extension.swift
//  SeSACFriends
//
//  Created by 신상원 on 2022/03/04.
//

import UIKit

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
