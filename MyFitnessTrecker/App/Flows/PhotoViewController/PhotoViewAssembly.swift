//
//  PhotoViewController.swift
//  MyFitnessTrecker
//
//  Created by ios_Dev on 10.06.2020.
//  Copyright © 2020 ios_Dev. All rights reserved.
//

import UIKit

class PhotoViewAssembly {
    let requestFactory = RequestFactory()
    private var viewController: PhotoViewController
    init(viewController: PhotoViewController) {
        self.viewController = viewController
    }
    
    func assembly() {
        let router = PhotoViewRouter(viewController: viewController)
        let presenter = PhotoViewPresenter(requestFactory: requestFactory,
                                          viewController: viewController,
                                          router: router)
        viewController.presenter = presenter
    }
}
