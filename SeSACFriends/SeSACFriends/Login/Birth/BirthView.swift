//
//  BirthView.swift
//  SeSACFriends
//
//  Created by 신상원 on 2022/01/22.
//

import SnapKit
import UIKit

class BirthView: UIView, ViewRepresentable {
    
    let mainLabel = UILabel()
    let ymdView = UIView()
    let yearView = DayView()
    let monthView = DayView()
    let dayView = DayView()
    
    let myButton = MyButton(frame: CGRect(), mode: .disable, text: "다음")
    let datePicker = UIDatePicker()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func setupView() {
        [mainLabel, ymdView, myButton, datePicker].forEach {
            self.addSubview($0)
        }
        
        [yearView, monthView, dayView].forEach {
            ymdView.addSubview($0)
        }
        
        mainLabel.textAlignment = .center
        mainLabel.textColor = UIColor(rgbString: ColorSet.black)
        mainLabel.font = FontSet.displayR20
        mainLabel.text = "생년월일을 알려주세요"
        
        yearView.refLabel.text = "년"
        yearView.dayLabel.text = "2022"
        monthView.refLabel.text = "월"
        monthView.dayLabel.text = "1"
        dayView.refLabel.text = "일"
        dayView.dayLabel.text = "22"
        
    }
    
    func setupConstraints() {
        mainLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(169)
            make.leading.equalToSuperview().offset(74)
            make.trailing.equalToSuperview().offset(-74)
        }
        
        ymdView.snp.makeConstraints { make in
            make.top.equalTo(mainLabel.snp.bottom).offset(80)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(48)
        }
        
        myButton.snp.makeConstraints { make in
            make.top.equalTo(ymdView.snp.bottom).offset(72)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(48)
        }
        
        datePicker.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.height.equalTo(216)
        }
        
        yearView.snp.makeConstraints { make in
            make.top.leading.bottom.equalToSuperview()
            make.width.equalTo(99)
        }
        
        dayView.snp.makeConstraints { make in
            make.top.bottom.trailing.equalToSuperview()
            make.width.equalTo(99)
        }
        
        monthView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.equalTo(yearView.snp.trailing).offset(23)
            make.trailing.equalTo(dayView.snp.leading).offset(-23)
        }
    }
    
}
