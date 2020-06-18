//
//  MapView.swift
//  MyFitnessTrecker
//
//  Created by ios_Dev on 10.06.2020.
//  Copyright © 2020 ios_Dev. All rights reserved.
//

import UIKit
import GoogleMaps
protocol MapViewDelegate: class {
    func findCenter()
    func startTracking()
    func stopTracking()
    func loadPreviousRoute()
}
class MapView: UIView {
    
    weak var delegate: MapViewDelegate?
    
    lazy var mapView: GMSMapView = {
        let view = GMSMapView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.mapType = .hybrid
        view.isTrafficEnabled = false
        return view
    }()
    
    lazy var setCenterButton: UIButton = {
    let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "center.png"), for: .normal)
        button.addTarget(self, action: #selector(setCenterButtonTapped), for: .touchUpInside)
        return button
    }()
    
    @objc func setCenterButtonTapped() {
        delegate?.findCenter()
    }
    
    lazy var goAndStopButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        //button.setImage(UIImage(named: "go.png"), for: .normal)
        button.setBackgroundImage(UIImage(named: "go.png"), for: .normal)
        button.contentMode = .scaleAspectFill
        button.addTarget(self, action: #selector(goAndStopButtonTapped(_:)), for: .touchUpInside)
        return button
    }()
    
    @objc func goAndStopButtonTapped(_ sender: UIButton) {
        if goAndStopButton.currentBackgroundImage == UIImage(named: "go.png"){
            delegate?.startTracking()
            goAndStopButton.setBackgroundImage(UIImage(named: "stop.png"), for: .normal)
        } else {
            delegate?.stopTracking()
            goAndStopButton.setBackgroundImage(UIImage(named: "go.png"), for: .normal)
        }
        
    }
    
    lazy var loadPreviousPathButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
     
        button.setImage(UIImage(named: "route.png"), for: .normal)
        button.addTarget(self, action: #selector(loadPreviousRoute), for: .touchUpInside)
        return button
    }()
    
    @objc func loadPreviousRoute(_ sender: UIButton) {
        delegate?.loadPreviousRoute()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    func configureUI() {
        addMap()
        addSetCenterButtonOnMap()
        addSGoAndStopButtonOnMap()
        addLoadPreviousPathButton()
    }
    
    func addMap() {
        addSubview(mapView)
        mapView.anchor(top: self.topAnchor, leading: self.leadingAnchor, bottom: self.bottomAnchor, trailing: self.trailingAnchor, padding: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
    }
    
    func addSetCenterButtonOnMap() {
        mapView.addSubview(setCenterButton)
        setCenterButton.anchor(top: nil, leading: nil, bottom: mapView.bottomAnchor, trailing: mapView.trailingAnchor, padding: UIEdgeInsets(top: 777, left: 777, bottom: 110, right: 15), size: CGSize(width: 50, height: 50))
    }
    
    func addSGoAndStopButtonOnMap() {
           mapView.addSubview(goAndStopButton)
           goAndStopButton.anchor(top: nil, leading: nil, bottom: mapView.bottomAnchor, trailing: nil, padding: UIEdgeInsets(top: 777, left: 777, bottom: 10, right: 777), size: CGSize(width: 120, height: 120))
        goAndStopButton.centerXAnchor.constraint(equalTo: mapView.centerXAnchor).isActive = true
       }
    
    func addLoadPreviousPathButton() {
        mapView.addSubview(loadPreviousPathButton)
        let height: CGFloat = 60
        loadPreviousPathButton.anchor(top: nil, leading: nil, bottom: nil, trailing: goAndStopButton.leadingAnchor, padding:.init(top: 777, left: 777, bottom: 777, right: 50), size: CGSize(width: 60, height: height))
        loadPreviousPathButton.layer.cornerRadius = height / 2
        loadPreviousPathButton.layer.masksToBounds = true
        loadPreviousPathButton.centerYAnchor.constraint(equalTo: goAndStopButton.centerYAnchor).isActive = true
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
