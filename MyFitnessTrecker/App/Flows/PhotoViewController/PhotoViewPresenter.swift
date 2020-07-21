//
//  PhotoViewController.swift
//  MyFitnessTrecker
//
//  Created by ios_Dev on 10.06.2020.
//  Copyright © 2020 ios_Dev. All rights reserved.
//

import UIKit

protocol PhotoViewPresenterProtocol {
    func goToMap()
}

class PhotoViewPresenter {
    private let requestFactory: RequestFactoryProtocol
      private var viewController: PhotoViewController
      private var router: PhotoViewRouterProtocol

      init(requestFactory: RequestFactoryProtocol,
           viewController: PhotoViewController,
           router: PhotoViewRouterProtocol) {
          self.requestFactory = requestFactory
          self.viewController = viewController
          self.router = router
      }
}
extension PhotoViewPresenter: PhotoViewPresenterProtocol {
    func goToMap() {
        router.goToMap()
    }
    
    
}
