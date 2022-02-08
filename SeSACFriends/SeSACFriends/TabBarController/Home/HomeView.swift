//
//  HomeView.swift
//  SeSACFriends
//
//  Created by 신상원 on 2022/02/06.
//

import SnapKit
import UIKit
import MapKit

class HomeView: UIView, ViewRepresentable {
    
    let mapView = MKMapView()
    let centerImage = UIImageView()
    var statusButtonView = StatusButtonView(frame: CGRect(), mode: .search)
    let buttonView = UIView()
    let allButton = MyButton(frame: CGRect(), mode: .inactive, text: "전체")
    let maleButton = MyButton(frame: CGRect(), mode: .inactive, text: "남자")
    let femaleButton = MyButton(frame: CGRect(), mode: .inactive, text: "여자")
    let gpsButton = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func setupView() {
        [mapView, statusButtonView, buttonView, gpsButton, centerImage].forEach {
            self.addSubview($0)
        }
        centerImage.image = UIImage(named: ImageSet.myPosition)
        centerImage.contentMode = .scaleAspectFit
        
        buttonView.backgroundColor = UIColor(rgbString: ColorSet.white)
        buttonView.clipsToBounds = true
        buttonView.layer.cornerRadius = 8
        
        buttonView.layer.borderWidth = 1
        buttonView.layer.borderColor = UIColor.white.cgColor
        buttonView.layer.shadowOpacity = 0.3
        buttonView.layer.shadowColor = UIColor.black.cgColor
        buttonView.layer.shadowOffset = CGSize(width: 0, height: 0)
        buttonView.layer.shadowRadius = 3
        buttonView.layer.masksToBounds = false
        
        gpsButton.backgroundColor = UIColor(rgbString: ColorSet.white)
        gpsButton.clipsToBounds = true
        gpsButton.layer.cornerRadius = 8
        gpsButton.setImage(UIImage(named: ImageSet.place), for: .normal)
        
        [allButton, maleButton, femaleButton].forEach {
            buttonView.addSubview($0)
        }
    }
    
    func setupConstraints() {
        mapView.snp.makeConstraints { make in
            make.leading.trailing.top.bottom.equalToSuperview()
        }
        
        centerImage.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.height.equalTo(48)
        }
        
        buttonView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.top.equalToSuperview().offset(52)
            make.width.equalTo(48)
            make.height.equalTo(144)
        }
        
        allButton.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(48)
        }
        
        maleButton.snp.makeConstraints { make in
            make.top.equalTo(allButton.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(48)
        }
        
        femaleButton.snp.makeConstraints { make in
            make.top.equalTo(maleButton.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
        }
        
        gpsButton.snp.makeConstraints { make in
            make.top.equalTo(buttonView.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(16)
            make.width.height.equalTo(48)
        }
        
        statusButtonView.snp.makeConstraints { make in
            make.width.height.equalTo(64)
            make.bottom.trailing.equalToSuperview().offset(-16)
        }
    }
}
