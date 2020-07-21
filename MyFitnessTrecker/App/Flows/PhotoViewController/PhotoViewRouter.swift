//
//  PhotoViewController.swift
//  MyFitnessTrecker
//
//  Created by ios_Dev on 10.06.2020.
//  Copyright © 2020 ios_Dev. All rights reserved.
//
import UIKit

protocol PhotoViewRouterProtocol: class {
    func goToMap()
}

class PhotoViewRouter {
    private var viewController: UIViewController
    
    init(viewController: UIViewController) {
        self.viewController = viewController
    }
}

extension PhotoViewRouter: PhotoViewRouterProtocol {
    func goToMap() {
        let mapViewController = MapViewController()
        mapViewController.assembler = MapViewAssembly(viewController: mapViewController)
        self.viewController.navigationController?.pushViewController(mapViewController, animated: true)
    }
    
    
}
