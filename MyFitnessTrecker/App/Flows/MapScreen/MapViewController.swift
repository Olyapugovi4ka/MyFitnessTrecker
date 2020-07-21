//
//  MapViewController.swift
//  MyFitnessTrecker
//
//  Created by ios_Dev on 10.06.2020.
//  Copyright © 2020 ios_Dev. All rights reserved.
//

import UIKit
import GoogleMaps
import RealmSwift

class MapViewController: UIViewController {
    
    
    private let mapView = MapView()
    
    var presenter: MapViewPresenterProtocol?
    var assembler: MapViewAssembly!
    
    var isTracking: Bool = false
    var image: UIImage?
    
    var route: GMSPolyline?
    var routePath: GMSMutablePath?
    var marker: GMSMarker?
    
    let locationManager = LocationManager.instance
    
    override func loadView() {
        self.view = mapView
        self.mapView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let back = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(goToLoginScreen))
        navigationItem.leftBarButtonItem = back
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.assembler.assembly()
        self.configureLocationManager()
        self.locationManager.requestLocaion()
        self.configureMap()
        self.mapView.mapView.clear()
    }
    
    @objc func goToLoginScreen() {
        self.presenter?.goToLoginViewController()
    }
    
    func configureMap() {
        _ = locationManager
            .location
            .asObservable()
            .bind { [weak self] location in
                guard let self = self else { return }
                guard let location = location else { return }
                
                let camera = GMSCameraPosition(target: location.coordinate, zoom: 17)
                self.mapView.mapView.camera = camera
                if self.marker == nil {
                    self.createMarker(position: location.coordinate)
                } else {
                    self.marker?.map = nil
                    self.marker = nil
                    self.createMarker(position: location.coordinate)
                }
               
        }
        
    }
    
    func setCameraToMap(camera: GMSCameraPosition) {
        self.mapView.mapView.camera = camera
    }
    
    func setCenter(with coordinates: CLLocationCoordinate2D) {
        self.mapView.mapView.animate(toLocation: coordinates)
    }
    
    func configureLocationManager(){
        _ = locationManager
            .location
            .asObservable()
            .bind { [weak self] location in
                guard let location = location else { return }
                self?.routePath?.add(location.coordinate)
                self?.route?.path = self?.routePath
                let position = GMSCameraPosition.camera(withTarget: location.coordinate, zoom: 17)
                self?.mapView.mapView.animate(to: position)
        }
    }
    
    func createMarker(position: CLLocationCoordinate2D)  {
        let marker = GMSMarker(position: position)
        let icon = UIImageView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        let image = ImageStore.loadImageFromDiskWith(fileName: "Selfy")
        icon.image = image ??  UIImage(named: "step.png")
        marker.iconView = icon
        marker.map = mapView.mapView
        self.marker = marker
      
    }
    
   
    
}
extension MapViewController: MapViewDelegate {
    func loadPreviousRoute() {
        if isTracking {
            let ac  = UIAlertController(title: "Warning", message: "Please, stop tracking", preferredStyle: .alert)
            let aa = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            ac.addAction(aa)
            self.present(ac, animated: true, completion: nil)
        } else {
            
            do {
                let realm = try Realm()
                let previousPath: Results <Path> = realm.objects(Path.self)
                guard let path = previousPath.first?.path else { return }
                routePath = GMSMutablePath(fromEncodedPath: path)
                guard let routePath = routePath else { return }
                let index = routePath.count() > 1 ? (routePath.count()) / 2 : 0
                let coordinate = routePath.coordinate(at: index)
                let distanse = routePath.length(of: .geodesic)
                route?.path = routePath
                
                route?.strokeColor = .yellow
                route?.map = mapView.mapView
                let zoom = GMSCameraPosition.zoom(at: coordinate, forMeters: distanse, perPoints: UIScreen.main.bounds.width - 20)
                let position = GMSCameraPosition.camera(withTarget: coordinate, zoom: zoom)
                mapView.mapView.animate(to: position)
            } catch {
                print(error)
            }
            
        }
    }
    
    func stopTracking() {
        self.locationManager.stopUpdaingLocation()
        if let routePath = routePath {
            let path = Path()
            path.path = routePath.encodedPath()
            do {
                let realm = try Realm()
                print(realm.configuration.fileURL!)
                
                try realm.write{
                    realm.deleteAll()
                    
                }
                try realm.write{
                    
                    realm.add(path)
                }
            } catch {
                print(error)
            }
        }
        self.mapView.mapView.clear()
        self.route?.map = nil
        self.marker?.map = nil
        self.marker = nil
        self.isTracking = false
    }
    
    func findCenter() {
        self.locationManager.requestLocaion()
        
    }
    
    func startTracking() {
        self.route?.map = nil
        self.route = GMSPolyline()
        self.routePath = GMSMutablePath()
        self.route?.path = routePath
        self.route?.strokeColor = .red
        self.route?.strokeWidth = 4
        self.route?.map = mapView.mapView
        self.locationManager.startUpdatingLocation()
        self.isTracking = true
    }
    
    
    
}


