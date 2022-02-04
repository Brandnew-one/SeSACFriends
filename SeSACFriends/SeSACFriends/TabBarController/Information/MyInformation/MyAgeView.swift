//
//  MyAgeView.swift
//  SeSACFriends
//
//  Created by 신상원 on 2022/01/27.
//

import DoubleSlider
import SnapKit
import UIKit

class MyAgeView: UIView, ViewRepresentable {
    
    let label = UILabel()
    let ageLabel = UILabel()
    var ageSlider = DoubleSlider()
    
    var labels: [String] = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraints()
        makeLabels()
        setupDoubleSlider()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func setupView() {
        [label, ageLabel, ageSlider].forEach {
            self.addSubview($0)
        }
        label.textColor = UIColor(rgbString: ColorSet.black)
        label.font = FontSet.title4R14
        label.text = "상대방 연령대"
        
        ageLabel.textColor = UIColor(rgbString: ColorSet.green)
        ageLabel.font = FontSet.title3M14
        ageLabel.text = "18 - 35"
    }
    
    func setupConstraints() {
        label.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.top.equalToSuperview().offset(13)
        }
        
        ageLabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview()
            make.top.equalToSuperview().offset(13)
        }
        
        // 높이가 중복되서 오류가 발생할 수 있는 지점! 문제가 생기면 여기 확인하기!
        ageSlider.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.bottom.equalToSuperview()
            make.trailing.equalToSuperview().offset(-13)
            make.top.equalTo(label.snp.bottom).offset(8)
            make.height.equalTo(38.0) // 38 보다 높이가 작은 경우에는 track 의 색깔이 오류
        }
    }
    
    private func makeLabels() {
        for num in stride(from: 18, to: 65, by: 1) {
            labels.append("\(num)")
        }
    }
    
    private func setupDoubleSlider() {
    
        ageSlider.labelDelegate = self
        ageSlider.labelsAreHidden = true
        
        ageSlider.trackHighlightTintColor = UIColor(rgbString: ColorSet.green)
        ageSlider.trackTintColor = UIColor(rgbString: ColorSet.gray2)
        ageSlider.thumbTintColor = UIColor(rgbString: ColorSet.green)
        ageSlider.numberOfSteps = labels.count
        ageSlider.smoothStepping = true
        
        ageSlider.lowerValueStepIndex = 0
        ageSlider.upperValueStepIndex = labels.count - 1
    
        ageSlider.addTarget(self, action: #selector(printVal(_:)), for: .valueChanged)
        
    }
    
    // 기존 라이브러리에서 제공하는 방법을 사용하면 index가 반영되지 않을 때가 있는 문제점 발생
    @objc func printVal(_ doubleSlider: DoubleSlider) {
//        print("Lower Step Index: \(doubleSlider.lowerValueStepIndex + 18) Upper Step Index: \(doubleSlider.upperValueStepIndex + 18)")
        ageLabel.text = "\(doubleSlider.lowerValueStepIndex + 18) - \(doubleSlider.upperValueStepIndex + 18)"
    }
}


extension MyAgeView: DoubleSliderLabelDelegate {
    func labelForStep(at index: Int) -> String? {
        return labels.item(at: index)
    }
}

extension Array {
    func item(at index: Int) -> Element? {
        return (index < self.count && index >= 0) ? self[index] : nil
    }
}
