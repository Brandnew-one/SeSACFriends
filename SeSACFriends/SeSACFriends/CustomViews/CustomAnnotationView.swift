//
//  CustomAnnotationView.swift
//  SeSACFriends
//
//  Created by 신상원 on 2022/02/06.
//

import SnapKit
import UIKit
import MapKit

enum AnnotationMode {
    case face1
    case face2
    case face3
    case face4
    case face5
}

class CustomAnnotationView: MKAnnotationView {
    
    static let identifier = "CustomAnnotationView"
    
    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
}

class CustomAnnotation: NSObject, MKAnnotation {
    
    var coordinate: CLLocationCoordinate2D
    var mode: AnnotationMode
    var title: String?
    
    init(coor: CLLocationCoordinate2D, mode: AnnotationMode) {
        self.coordinate = coor
        self.mode = mode
    }
    
}
