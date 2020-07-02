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
    
    //timer
    var timer: Timer?
    
    // Время, когда таймер был запущен
    var startTime: Date?
    // Интервал, в течение которого должен работать таймер, в секундах
    let timeInterval: TimeInterval = 180
    // Идентификатор фоновой задачи
    var beginBackgroundTask: UIBackgroundTaskIdentifier?
    
    
    var route: GMSPolyline?
    var routePath: GMSMutablePath?
    
//    var locationManager: CLLocationManager?
    let locationManager = LocationManager.instance
    
    override func loadView() {
        self.view = mapView
        mapView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let back = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(goToLoginScreen))
        navigationItem.leftBarButtonItem = back
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        assembler.assembly()
        configureLocationManager()
        //locationManager?.requestLocation()
        locationManager.requestLocaion()
        configureMap()
        mapView.mapView.clear()
        //configureTimer()
    }
    
    @objc func goToLoginScreen() {
        presenter?.goToLoginViewController()
    }
    
    // for timer
    func configureTimer() {
        beginBackgroundTask = UIApplication.shared.beginBackgroundTask { [weak self] in
            guard let beginBackgroundTask = self?.beginBackgroundTask else { return }
            // Гарантированная очистка фоновой задачи при её прекращении
            UIApplication.shared.endBackgroundTask(beginBackgroundTask)
            self?.beginBackgroundTask = UIBackgroundTaskIdentifier.invalid

        }
        // Запоминаем время запуска таймера
        startTime = Date()

        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { /*[weak self] */_ in
            print(Date())
        }
    }
    
    func configureMap() {
        locationManager
            .location
            .asObservable()
            .bind { [weak self] location in
                guard let location = location else { return }
                
                let camera = GMSCameraPosition(target: location.coordinate, zoom: 17)
                self?.mapView.mapView.camera = camera
        }
        
    }
    
    func setCameraToMap(camera: GMSCameraPosition) {
        mapView.mapView.camera = camera
    }
    
    func setCenter(with coordinates: CLLocationCoordinate2D) {
        mapView.mapView.animate(toLocation: coordinates)
    }
    
    func configureLocationManager(){
        locationManager
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
        locationManager.stopUpdaingLocation()
        if let routePath = routePath {
            let path = Path()
            path.path = routePath.encodedPath()
            do {
                let realm = try Realm()
                print(realm.configuration.fileURL)
                
                try! realm.write{
                    realm.deleteAll()
                    
                }
                try! realm.write{
                    
                    realm.add(path)
                }
            } catch {
                print(error)
            }
        }
        mapView.mapView.clear()
        route?.map = nil
        isTracking = false
    }
    
    func findCenter() {
        locationManager.requestLocaion()
        
    }
    
    func startTracking() {
        route?.map = nil
        route = GMSPolyline()
        routePath = GMSMutablePath()
        route?.path = routePath
        route?.strokeColor = .red
        route?.strokeWidth = 4
        route?.map = mapView.mapView
         locationManager.startUpdatingLocation()
        isTracking = true
    }
    
}


