//
//  Locais.swift
//  Vanttage-v2
//
//  Created by leo on 11/10/16.
//  Copyright © 2016 tap4. All rights reserved.
//

import UIKit
import MapKit

class Locais: NSObject, MKAnnotation {
    
    var title: String?
    var subtitle: String?
    var latitude: Double
    var longitude: Double
    var teste: Bool?
    var image: String?
    var fone : String?
    var endereco: String?
    var coordinate: CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    init(latitude: Double, longitude: Double) {
        self.latitude = latitude
        self.longitude = longitude
    }
    
}
