//
//  HomeViewController.swift
//  SeSACFriends
//
//  Created by 신상원 on 2022/01/23.
//

import CoreLocation
import CoreLocationUI
import MapKit
import UIKit

class HomeViewController: UIViewController, ViewRepresentable {
    
    let homeView = HomeView()
    let locationManager = CLLocationManager()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
        self.tabBarController?.tabBar.isHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupView()
        setupConstraints()
        
        homeView.mapView.delegate = self // 안해주면 오류 발생하는 거 확인
        locationManager.delegate = self
        
        checkUserLocationServicesAuthorization()
        
        homeView.gpsButton.addTarget(self, action: #selector(gpsButtonClicked), for: .touchUpInside)
        homeView.statusButtonView.button.addTarget(self, action: #selector(statusButtonClicked), for: .touchUpInside)
    }
    
    @objc func statusButtonClicked() {
        let vc = HobbyViewController()
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    @objc func gpsButtonClicked() {
        // 현재 위치를 지도의 중심으로 설정한다(CenterImage 가 가리키는 좌표)
        let coordinate = homeView.mapView.centerCoordinate
        addCustomAnnotation(Location: coordinate, mode: .face1)
        
        let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01) // 축척비율
        let region = MKCoordinateRegion(center: coordinate, span: span)
        homeView.mapView.setRegion(region, animated: true)
        
        locationManager.stopUpdatingLocation()
    }
    
    func setupView() {
        view.addSubview(homeView)
    }
    
    func setupConstraints() {
        homeView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
}

extension HomeViewController: CLLocationManagerDelegate {
    
    func checkUserLocationServicesAuthorization() {
        let authorizationStatus: CLAuthorizationStatus
        
        //14 부터는 정확도 설정이 들어가기 때문에 시스템 설정도 다르게 (8) 에서 보면 열거형의 구성이 추가되어 있음)
        if #available(iOS 14.0, *) {
            authorizationStatus = locationManager.authorizationStatus //iOS 14 이상만 사용가능
        }
        else {
            authorizationStatus = CLLocationManager.authorizationStatus() // iOS 14 미만
        }
        
        //iOS 위치 서비스 확인 -> 시스템상에서 위치 허용이 되어 있으면 -> 앱 내에서의 위치 권한 확인
        if CLLocationManager.locationServicesEnabled() {
            //권한 상태 확인 및 권한 요청가능 -> 8번 메서드 실행
            checkCurrentLocationAuthorization(authorizationStatus)
        }
        //아예 시스템에서 위치 기능을 끈 경우
        else {
            showAlert(title: "설정으로 이동", message: "권한 허용해주세요", okTitle: "설정으로 가기") {
                guard let url = URL(string: UIApplication.openSettingsURLString) else {
                    return
                }
                
                if UIApplication.shared.canOpenURL(url) {
                    UIApplication.shared.open(url) { success in
                        print("잘 열렸다. \(success)")
                    }
                }
            }
            //취소 버튼을 누른 경우
            print("iOS 위치 서비스를 켜주세요!")
        }
    }
    
    
    // 8) 사용자의 권한 상태 확인
    func checkCurrentLocationAuthorization(_ authorizationStatus: CLAuthorizationStatus) {
        
        switch authorizationStatus {
        case .notDetermined:
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestWhenInUseAuthorization() // 앱을 사용하는 동안에 대한 위치 권환 요청
            locationManager.startUpdatingLocation() // 위치 접근 시작! (같이 나와야함)
            
        // 사용자가 위치 설정을 허용해주지 않은 경우
        case .restricted, .denied:
            print("Denied, 설정으로 유도")
            showAlert(title: "설정으로 이동", message: "권한 허용해주세요", okTitle: "설정으로 가기") {
                guard let url = URL(string: UIApplication.openSettingsURLString) else {
                    return
                }
                if UIApplication.shared.canOpenURL(url) {
                    UIApplication.shared.open(url) { success in
                        print("잘 열렸다. \(success)")
                    }
                }
            }
        
        // 한 번 허용
        case .authorizedWhenInUse:
            locationManager.startUpdatingLocation()
        
        // 항상 허용
        case .authorizedAlways:
            print("Always")
            
        @unknown default:
            print("Default")
        }
        
        // 14.0 이상부터는 위치에 접근할 때 정확도 설정이 추가됨
        if #available(iOS 14.0, *) {
            //정확토 체크: 정확도 감소가 되어 있을 경우, 1시간 4번으로 제한
            let accurancyState = locationManager.accuracyAuthorization
            switch accurancyState {
            // 정확한 위치 설정을 허용한 경우
            case .fullAccuracy:
                print("Full")
            // 대략적인 위치 설정을 허용한 경우
            case .reducedAccuracy:
                print("Reduce")
            @unknown default:
                print("Default")
            }
        }
    }
    
    
    // 4) 사용자가 앱 내에서 위치 허용을 한 경우,
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        print("감사합니다. 허용해 주셔서")
        
        // 사용자가 앱 내에서 위치 허용을 해줬으니까 현재 위치를 지도의 중심으로 설정한다.
        if let coordinate = locations.last?.coordinate {
            let annotation = MKPointAnnotation()
            annotation.title = "현재 내 위치"
            annotation.coordinate = coordinate
            homeView.mapView.addAnnotation(annotation)
            
            let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01) // 축척비율
            let region = MKCoordinateRegion(center: coordinate, span: span)
            print(region)
            homeView.mapView.setRegion(region, animated: true)
            
            //10. 중요!!
            locationManager.stopUpdatingLocation()
            
        }
        
        //얘기치 못한 오류 방지 (비행기 모드로 변환되었을 경우) <-> 5번함수와의 기능
        else {
            print("Location Cannot Find")
        }
    }
    
    // 5) 위치 접근에 실패한 경우 (사용자가 위치 접근을 거부한 경우 + 초기에 사용자에게 위치 접근을 묻는 경우에도(오류나는거니까))
    // 위치접근을 허용했으나 위치 정보 조회에 실패한 경우 지도에서 어떤화면을 보여줄 것인가?
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("허용 안했어? 왜 오류가 나!")
    }
    
    // 6) iOS 14 이상
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        print("승인상태 변경")
        checkUserLocationServicesAuthorization()
    }
    
    // 7) iOS 14 미만
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        print("승인상태 변경")
        checkUserLocationServicesAuthorization()
    }

}

extension HomeViewController: MKMapViewDelegate {

    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            
        guard let annotation = annotation as? CustomAnnotation else {
            return nil
        }
           
        var annotationView = self.homeView.mapView.dequeueReusableAnnotationView(withIdentifier: CustomAnnotationView.identifier)
        
        if annotationView == nil {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: CustomAnnotationView.identifier)
            annotationView?.canShowCallout = false
            annotationView?.contentMode = .scaleAspectFit
            
        } else {
            annotationView?.annotation = annotation
        }
        
        let annotationImage: UIImage!
        let size = CGSize(width: 85, height: 85)
        UIGraphicsBeginImageContext(size)
        
        switch annotation.mode {
        case .face1:
            annotationImage = UIImage(named: ImageSet.face1)
        case .face2:
            annotationImage = UIImage(named: ImageSet.face2)
        case .face3:
            annotationImage = UIImage(named: ImageSet.face3)
        case .face4:
            annotationImage = UIImage(named: ImageSet.face4)
        case .face5:
            annotationImage = UIImage(named: ImageSet.face5)
        }

        annotationImage.draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
        annotationView?.image = resizedImage
        
        return annotationView
    }
        
    func addCustomAnnotation(Location: CLLocationCoordinate2D, mode: AnnotationMode) {
        let missionDoloresCoor = Location
        let pin = CustomAnnotation(coor: missionDoloresCoor, mode: mode)
        self.homeView.mapView.addAnnotation(pin)
    }
    
}
