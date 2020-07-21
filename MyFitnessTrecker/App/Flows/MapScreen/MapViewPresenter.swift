//
//  MapViewPresenter.swift
//  StorageLLC
//
//  Created by ios_Dev on 10.06.2020.
//  Copyright © 2020 ios_Dev. All rights reserved.
//

import Foundation
import  GoogleMaps
import  CoreLocation

protocol MapViewPresenterProtocol {
   func goToLoginViewController()
}

class MapViewPresenter {
    private let requestFactory: RequestFactoryProtocol
    private var viewController: MapViewController
    private var router: MapViewRouterProtocol
    
    //var locationManager: CLLocationManager?
    let coordinate = CLLocationCoordinate2D(latitude: 55.753215, longitude: 37.622504)
    
    init(requestFactory: RequestFactoryProtocol,
         viewController: MapViewController,
         router: MapViewRouterProtocol) {
        self.requestFactory = requestFactory
        self.viewController = viewController
        self.router = router
    }
   
}
extension MapViewPresenter: MapViewPresenterProtocol {
    func goToLoginViewController() {
        router.goToMapViewController()
    }
    
}

    

