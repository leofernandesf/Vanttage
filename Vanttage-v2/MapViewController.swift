//
//  MapViewController.swift
//  Vanttage
//
//  Created by leo on 27/09/16.
//  Copyright © 2016 tap4. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController,MKMapViewDelegate,CLLocationManagerDelegate {
    
    @IBOutlet weak var myMap: MKMapView!
    let locationManager = CLLocationManager()
    
    let regionRadius: CLLocationDistance = 1000
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // set initial location in Honolulu
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()

        
        myMap.showsUserLocation = true


        
    }
    
    
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
                                                                  regionRadius * 2.0, regionRadius * 2.0)
        myMap.setRegion(coordinateRegion, animated: true)
        print(myMap.userLocation.coordinate.latitude)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations.last
        let coordinateRegion = MKCoordinateRegionMakeWithDistance((location?.coordinate)!,
                                                                  regionRadius * 2.0, regionRadius * 2.0)
        //let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1))
        self.myMap.setRegion(coordinateRegion, animated: true)
        self.locationManager.stopUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
    
}
