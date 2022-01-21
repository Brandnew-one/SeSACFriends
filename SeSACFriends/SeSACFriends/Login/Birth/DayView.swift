//
//  DayView.swift
//  SeSACFriends
//
//  Created by 신상원 on 2022/01/22.
//

import SnapKit
import UIKit

class DayView: UIView,ViewRepresentable {
    
    let dayLabel = UILabel()
    let refLabel = UILabel() // 년,월,일
    let lineView = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func setupView() {
        [dayLabel, refLabel, lineView].forEach {
            self.addSubview($0)
        }
        
        dayLabel.font = FontSet.title4R14
        dayLabel.textAlignment = .center
        dayLabel.textColor = UIColor(rgbString: ColorSet.gray7)
        
        refLabel.font = FontSet.title2R16
        refLabel.textAlignment = .center
        refLabel.textColor = UIColor(rgbString: ColorSet.black)
        
        lineView.backgroundColor = UIColor(rgbString: ColorSet.gray3)
    }
    
    func setupConstraints() {
        dayLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(13)
            make.leading.equalToSuperview().offset(12)
            make.trailing.equalTo(refLabel.snp.leading).offset(-40)
            make.bottom.equalToSuperview().offset(-13)
        }
        
        refLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(11)
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview().offset(-11)
        }
        
        lineView.snp.makeConstraints { make in
            make.leading.bottom.equalToSuperview()
            make.trailing.equalTo(refLabel.snp.leading).offset(-4)
            make.height.equalTo(1)
        }
    }
    
    
}
