//
//  AnywhereViewController.swift
//  twelve-months
//
//  Created by Anton Quietzsch on 16.12.19.
//  Copyright © 2019 Anton Quietzsch. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class AnywhereViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {

    @IBOutlet weak var mapView: MKMapView!
    
    var locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.showsUserLocation = true
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations.last! as CLLocation
        show(user: location)
        country(from: location)
    }
    
    func show(user location: CLLocation) {
        let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 50, longitudeDelta: 50))
        self.mapView.setRegion(region, animated: true)
        print("\(location.coordinate.latitude) \(location.coordinate.longitude)")
    }
    
    func country(from location: CLLocation) {
        
    }

}
