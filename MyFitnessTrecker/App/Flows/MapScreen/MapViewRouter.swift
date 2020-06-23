//
//  MapViewRouter.swift
//  StorageLLC
//
//  Created by ios_Dev on 10.06.2020.
//  Copyright © 2020 ios_Dev. All rights reserved.
//

import UIKit

protocol MapViewRouterProtocol: class {
    func goToMapViewController()
}

class MapViewRouter {
    private var viewController: UIViewController
    
    init(viewController: UIViewController) {
        self.viewController = viewController
    }
}

extension MapViewRouter: MapViewRouterProtocol {
    func goToMapViewController() {
        let loginViewController = LoginViewController()
        loginViewController.assembler = LoginViewAssembly(viewController: loginViewController)
        viewController.navigationController?.pushViewController(loginViewController, animated: true)
    }
    
    
    
    
}
