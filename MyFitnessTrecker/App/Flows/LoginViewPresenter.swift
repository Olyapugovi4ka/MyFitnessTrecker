//
//  LoginViewPresenter.swift
//  StorageLLC
//
//  Created by ios_Dev on 22.05.2020.
//  Copyright © 2020 ios_Dev. All rights reserved.
//

import Foundation

protocol LoginViewPresenterProtocol {
    func goToMapViewController()
}

class LoginViewPresenter {
    private let requestFactory: RequestFactoryProtocol
      private var viewController: LoginViewController
      private var router: LoginViewRouterProtocol

      init(requestFactory: RequestFactoryProtocol,
           viewController: LoginViewController,
           router: LoginViewRouterProtocol) {
          self.requestFactory = requestFactory
          self.viewController = viewController
          self.router = router
      }
}
extension LoginViewPresenter: LoginViewPresenterProtocol {
    func goToMapViewController() {
         print(#function)
        router.goToMapViewController()
    }
    
    
}
