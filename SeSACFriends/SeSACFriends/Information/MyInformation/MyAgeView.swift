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
    let ageSlider = DoubleSlider()
    
    var labels: [String] = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        makeLabels()
        setupDoubleSlider()
        setupView()
        setupConstraints()
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
        
        ageLabel.textColor = UIColor(rgbString: ColorSet.green)
        ageLabel.font = FontSet.title3M14
    }
    
    func setupConstraints() {
        label.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.top.equalToSuperview().offset(13)
            make.bottom.equalToSuperview().offset(-13)
        }
        
        ageLabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview()
            make.top.equalToSuperview().offset(13)
            make.bottom.equalToSuperview().offset(-13)
        }
        
        ageSlider.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(12)
            make.trailing.equalToSuperview().offset(-12)
            make.bottom.equalToSuperview().offset(-18)
            make.height.equalTo(24)
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
        ageSlider.thumbTintColor = UIColor(rgbString: ColorSet.green)
        ageSlider.numberOfSteps = labels.count
        ageSlider.smoothStepping = true
        
        ageSlider.lowerValueStepIndex = 0
        ageSlider.upperValueStepIndex = labels.count - 1
        
        // You can use traditional notifications
//        ageSlider.addTarget(self, action: #selector(printVal(_:)), for: .valueChanged)
        // Or Swifty delegates
        ageSlider.editingDidEndDelegate = self
    }
    
//    @objc func printVal(_ doubleSlider: DoubleSlider) {
//        print("Lower: \(doubleSlider.lowerValue) Upper: \(doubleSlider.upperValue)")
//    }
    
}

extension MyAgeView: DoubleSliderEditingDidEndDelegate {
    func editingDidEnd(for doubleSlider: DoubleSlider) {
        print("Lower Step Index: \(doubleSlider.lowerValueStepIndex) Upper Step Index: \(doubleSlider.upperValueStepIndex)")
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
