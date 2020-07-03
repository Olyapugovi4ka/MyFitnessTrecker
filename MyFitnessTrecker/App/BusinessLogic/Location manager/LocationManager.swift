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
        print("LocationManager init")
        configureLocationManager​()
    }
    let locationManager = CLLocationManager()
    //var location: CLLocation? = nil
    let location: BehaviorRelay<CLLocation?> = BehaviorRelay(value: nil)
    func startUpdatingLocation() {
        self.locationManager.startUpdatingLocation()
    }
    
    func  requestLocaion() {
        self.locationManager.requestLocation()
    }
    
    func stopUpdaingLocation() {
        self.locationManager.stopUpdatingLocation()
    }
    
    private func configureLocationManager​() {
        self.locationManager.delegate = self
        self.locationManager.allowsBackgroundLocationUpdates = true
        self.locationManager.pausesLocationUpdatesAutomatically = false
        self.locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        self.locationManager.startMonitoringSignificantLocationChanges()
        self.locationManager.requestAlwaysAuthorization()
    }
    deinit {
            print("LocationManager deinit")
       }
}
extension LocationManager: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        //print(locations.first)
        //location = locations.last
        self.location.accept(locations.last)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
   
}
