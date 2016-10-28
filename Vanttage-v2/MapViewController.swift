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
    
    @IBOutlet weak var myView: UIView!
    @IBOutlet weak var lugarFone: UILabel!
    @IBOutlet weak var lugarEndereco: UILabel!
    @IBOutlet weak var lugarNome: UILabel!
    let regionRadius: CLLocationDistance = 1000
    
    var companies: [Companies]?
    
    var anotations: [Locais]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("entrou")
        // set initial location in Honolulu
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        myMap.showsUserLocation = true
        myMap.delegate = self
        
        let local = Locais()
        
        anotations = local.retornaLocais(companies: companies!)
        self.myMap.addAnnotations(anotations!)

        
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
    
    
    @IBAction func detalhes(_ sender: AnyObject) {
        print("vai")
        let es = self.storyboard?.instantiateViewController(withIdentifier: "detalhesEstabelecimento") as? EstabelecimentoViewController
        self.navigationController?.pushViewController(es!, animated: true)
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
    
    func mapView(_ mapView: MKMapView, didDeselect view: MKAnnotationView) {
        print("vai")
        self.myView.isHidden = true
    }
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        
        let ano: Locais = view.annotation as! Locais
        self.lugarFone.text = ano.fone
        self.lugarNome.text = ano.title
        self.lugarEndereco.text = ano.endereco
        self.myView.isHidden = false
    }
}

