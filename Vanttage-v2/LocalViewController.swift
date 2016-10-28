//
//  LocalViewController.swift
//  Vanttage-v2
//
//  Created by leo on 18/10/16.
//  Copyright © 2016 tap4. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class LocalViewController: UIViewController,MKMapViewDelegate,CLLocationManagerDelegate {

    @IBOutlet weak var myMap: MKMapView!
    let regionRadius: CLLocationDistance = 1000
    var local: Companies?
    var lat : Double?
    var long: Double?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpAnnotation()
    }
    
    
    
    func setUpAnnotation() {
        self.lat = Double((local?.lat!)!)!
        self.long = Double((local?.long!)!)!
        let location = CLLocationCoordinate2D(latitude: lat!,longitude: long!)
        
        let span = MKCoordinateSpanMake(0.1, 0.1)
        
        let region = MKCoordinateRegion(center: location, span: span)
        
        
        myMap.setRegion(region, animated: true)
        
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = location
        
        if let titulo = local?.nome {
            annotation.title = titulo
        }
        
        
        myMap.addAnnotation(annotation)
    }

    
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard !annotation.isKind(of: MKUserLocation.self) else {
            return nil
        }
        
        let annotationIdentifier = "AnnotationIdentifier"
        
        var annotationView: MKAnnotationView?
        if let dequeuedAnnotationView = mapView.dequeueReusableAnnotationView(withIdentifier: annotationIdentifier) {
            annotationView = dequeuedAnnotationView
            annotationView?.annotation = annotation
        }
        else {
            let av = MKAnnotationView(annotation: annotation, reuseIdentifier: annotationIdentifier)
            //av.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
            annotationView = av
        }
        
        if let annotationView = annotationView {
            // Configure your annotation view here
            annotationView.canShowCallout = true
            let pinImage = UIImage(named: "pin_ic")
            let image = layout.sizeImage(width: 27, height: 38, image: pinImage!)
            
            annotationView.image = image
        }
        
        return annotationView
    }
}
