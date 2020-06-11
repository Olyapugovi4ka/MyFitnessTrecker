//
//  MapViewController.swift
//  MyFitnessTrecker
//
//  Created by ios_Dev on 10.06.2020.
//  Copyright © 2020 ios_Dev. All rights reserved.
//

import UIKit
import GoogleMaps

class MapViewController: UIViewController {

    
    private let mapView = MapView()
    
    var presenter: MapViewPresenterProtocol?
    var assembler: MapViewAssembly!
    
    var locationManager: CLLocationManager?
    
    override func loadView() {
        self.view = mapView
        mapView.delegate = self
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        assembler.assembly()
        configureLocationManager()
        locationManager?.requestLocation()
    }
    
    func setCameraToMap(camera: GMSCameraPosition) {
        mapView.mapView.camera = camera
    }
    
    func setCenter(with coordinates: CLLocationCoordinate2D) {
        mapView.mapView.animate(toLocation: coordinates)
    }
    
    func configureLocationManager(){
        locationManager = CLLocationManager()
        locationManager?.requestWhenInUseAuthorization()
        locationManager?.delegate = self
    }
        
}
extension MapViewController: MapViewDelegate {
    func findCenter() {
        //presenter?.findCenter()
        locationManager?.requestLocation()
        
    }
    
    func startTracking() {
        locationManager?.startUpdatingLocation()
    }
    
}

extension MapViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let camera = GMSCameraPosition.camera(withTarget: locations.first!.coordinate, zoom: 17)
        mapView.mapView.camera = camera
        let marker = GMSMarker(position: locations.first!.coordinate)
        marker.map = mapView.mapView
        let coder = CLGeocoder()
        coder.reverseGeocodeLocation(locations.first!) { (places, error) in
            if let error = error {
                print(error.localizedDescription)
            } else {
                print(places?.first?.administrativeArea as Any)
                print(places?.first?.country as Any)
                print(places?.first?.name as Any)
                print("-----------------")
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
}
