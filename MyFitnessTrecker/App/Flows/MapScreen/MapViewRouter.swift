//
//  MapViewRouter.swift
//  StorageLLC
//
//  Created by ios_Dev on 22.05.2020.
//  Copyright © 2020 ios_Dev. All rights reserved.
//

import UIKit

protocol MapViewRouterProtocol: class {
    
}

class MapViewRouter {
    private var viewController: UIViewController
    
    init(viewController: UIViewController) {
        self.viewController = viewController
    }
}

extension MapViewRouter: MapViewRouterProtocol {
    
}
