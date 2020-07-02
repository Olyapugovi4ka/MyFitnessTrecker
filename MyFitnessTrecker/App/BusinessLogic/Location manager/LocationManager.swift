//
//  LocationManager.swift
//  MyFitnessTrecker
//
//  Created by ios_Dev on 02.07.2020.
//  Copyright © 2020 ios_Dev. All rights reserved.
//

import Foundation
import CoreLocation
import RxSwift
import RxCocoa


final class LocationManager: NSObject {
    
    static let instance = LocationManager()
    
    private override init() {
        super.init()
        configureLocationManager​()
    }
    let locationManager = CLLocationManager()
    //var location: CLLocation? = nil
    let location: BehaviorRelay<CLLocation?> = BehaviorRelay(value: nil)
    func startUpdatingLocation() {
        locationManager.startUpdatingLocation()
    }
    
    func  requestLocaion() {
        locationManager.requestLocation()
    }
    
    func stopUpdaingLocation() {
        locationManager.stopUpdatingLocation()
    }
    
    private func configureLocationManager​() {
        locationManager.delegate = self
        locationManager.allowsBackgroundLocationUpdates = true
        locationManager.pausesLocationUpdatesAutomatically = false
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        locationManager.startMonitoringSignificantLocationChanges()
        locationManager.requestAlwaysAuthorization()
    }
}
extension LocationManager: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print(locations.first)
        //location = locations.last
        self.location.accept(locations.last)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}
