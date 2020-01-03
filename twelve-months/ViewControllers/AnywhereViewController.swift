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
    let span = MKCoordinateSpan(latitudeDelta: 10, longitudeDelta: 10)

    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    //MARK: Delegate methods
    
    /// Tells the MapView to display the user's location
    /// The map will only zoom to the region of the user once
    /// - Parameters:
    ///   - manager: The location manager object that generated the update event.
    ///   - locations: An array of CLLocation objects containing the location data. This array always contains at least one object representing the current location.
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            //  let location = locations.last! as CLLocation
            let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
            let region = MKCoordinateRegion(center: center, span: span)
            if !mapDidShowUserLocationOnce {
                self.mapView.setRegion(region, animated: true)
                mapDidShowUserLocationOnce.toggle()
            }
        }
    }

}
