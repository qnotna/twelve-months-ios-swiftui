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
    
    var mapDidShowUserLocationOnce = false
    var locationManager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            //  let location = locations.last! as CLLocation
            let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
            let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 10, longitudeDelta: 10))
            if !mapDidShowUserLocationOnce {
                self.mapView.setRegion(region, animated: true)
                mapDidShowUserLocationOnce.toggle()
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Failed to find user's location: \(error.localizedDescription)")
    }
}
