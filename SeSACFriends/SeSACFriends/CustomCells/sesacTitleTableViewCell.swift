//
//  sesacTitleTableViewCell.swift
//  SeSACFriends
//
//  Created by 신상원 on 2022/01/31.
//

import SnapKit
import UIKit

class sesacTitleView: UIView {
    
    let titleSet = ["좋은 매너", "정확한 시간 약속", "빠른 응답", "친절한 성격", "능숙한 취미실력", "유익한 시간"]
    
    var cellLabel = UILabel()
    var cellTitles: [TitleView] = []
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupTitleSet()
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    
    func setupTitleSet() {
        for title in titleSet {
            let titleView = TitleView(frame: CGRect(), title: title, isOn: false)
            cellTitles.append(titleView)
        }
    }
    
    func setupView() {
        self.addSubview(cellLabel)
        cellLabel.text = "새싹 타이틀"
        cellLabel.font = FontSet.title6R12
        cellLabel.textColor = UIColor(rgbString: ColorSet.black)
        
        cellTitles.forEach {
            self.addSubview($0)
        }
    }
    
    func setupConstraints() {
        cellLabel.snp.makeConstraints { make in
            make.top.leading.equalToSuperview()
        }
        
        cellTitles[0].snp.makeConstraints { make in
            make.top.equalTo(cellLabel.snp.bottom).offset(16)
            make.leading.equalToSuperview()
            make.width.equalTo(cellTitles[1].snp.width)
            make.height.equalTo(32)
        }
        
        cellTitles[1].snp.makeConstraints { make in
            make.top.equalTo(cellLabel.snp.bottom).offset(16)
            make.leading.equalTo(cellTitles[0].snp.trailing).offset(8)
            make.trailing.equalToSuperview()
            make.height.equalTo(32)
        }
        
        cellTitles[2].snp.makeConstraints { make in
            make.top.equalTo(cellTitles[0].snp.bottom).offset(8)
            make.leading.equalToSuperview()
            make.width.equalTo(cellTitles[3].snp.width)
            make.height.equalTo(32)
        }
        
        cellTitles[3].snp.makeConstraints { make in
            make.top.equalTo(cellTitles[1].snp.bottom).offset(8)
            make.leading.equalTo(cellTitles[2].snp.trailing).offset(8)
            make.trailing.equalToSuperview()
            make.height.equalTo(32)
        }
        
        cellTitles[4].snp.makeConstraints { make in
            make.top.equalTo(cellTitles[2].snp.bottom).offset(8)
            make.leading.equalToSuperview()
            make.width.equalTo(cellTitles[5].snp.width)
            make.height.equalTo(32)
        }
        
        cellTitles[5].snp.makeConstraints { make in
            make.top.equalTo(cellTitles[3].snp.bottom).offset(8)
            make.leading.equalTo(cellTitles[4].snp.trailing).offset(8)
            make.trailing.equalToSuperview()
            make.height.equalTo(32)
        }
        
    }
    
    
}

