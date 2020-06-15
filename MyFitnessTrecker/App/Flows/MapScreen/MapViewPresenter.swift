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
   func setMarker(to map: GMSMapView)
  
}

class MapViewPresenter {
    private let requestFactory: RequestFactoryProtocol
    private var viewController: MapViewController
    private var router: MapViewRouterProtocol
    
    //var locationManager: CLLocationManager?
    let coordinate = CLLocationCoordinate2D(latitude: 55.753215, longitude: 37.622504)
    var marker: GMSMarker?
    
    init(requestFactory: RequestFactoryProtocol,
         viewController: MapViewController,
         router: MapViewRouterProtocol) {
        self.requestFactory = requestFactory
        self.viewController = viewController
        self.router = router
    }
   
}
extension MapViewPresenter: MapViewPresenterProtocol {
    
    func setMarker(to map: GMSMapView) {
//        if marker == nil {
//            let marker = GMSMarker(position: coordinate)
//            let icon = UIImageView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
//            icon.image = UIImage(named: "step.png")
//            marker.iconView = icon
//            marker.map = map
//            self.marker = marker
//        } else {
//            marker?.map = nil
//            marker = nil
//        }
        
    }
    
    func loadMapCenter() {
        
    }
    
    func findCenter() {
        viewController.setCenter(with: coordinate)
        
    }
    
    
    
}

    

