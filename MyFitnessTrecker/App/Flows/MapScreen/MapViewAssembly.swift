//
//  MapViewAssembly.swift
//  StorageLLC
//
//  Created by ios_Dev on 22.05.2020.
//  Copyright © 2020 ios_Dev. All rights reserved.
//

import UIKit

class MapViewAssembly {
    let requestFactory = RequestFactory()
    private var viewController: MapViewController
    init(viewController: MapViewController) {
        self.viewController = viewController
    }
    
    func assembly() {
        let router = MapViewRouter(viewController: viewController)
        let presenter = MapViewPresenter(requestFactory: requestFactory,
                                          viewController: viewController,
                                          router: router)
        viewController.presenter = presenter
    }
}
