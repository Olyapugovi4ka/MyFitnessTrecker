//
//  LoginViewRouter.swift
//  StorageLLC
//
//  Created by ios_Dev on 22.05.2020.
//  Copyright © 2020 ios_Dev. All rights reserved.
//

import UIKit

protocol LoginViewRouterProtocol: class {
    func goToMapViewController()
}

class LoginViewRouter {
    private var viewController: UIViewController
    
    init(viewController: UIViewController) {
        self.viewController = viewController
    }
}

extension LoginViewRouter: LoginViewRouterProtocol {
    func goToMapViewController() {
        print(#function)
        let mapViewController = MapViewController()
        mapViewController.assembler = MapViewAssembly(viewController: mapViewController)
        self.viewController.navigationController?.pushViewController(mapViewController, animated: true)
    }
    
    
}
