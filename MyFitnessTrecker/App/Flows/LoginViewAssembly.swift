//
//  LoginViewAssembly.swift
//  StorageLLC
//
//  Created by ios_Dev on 22.05.2020.
//  Copyright © 2020 ios_Dev. All rights reserved.
//

import UIKit

class LoginViewAssembly {
    let requestFactory = RequestFactory()
    private var viewController: LoginViewController
    init(viewController: LoginViewController) {
        self.viewController = viewController
    }
    
    func assembly() {
        let router = LoginViewRouter(viewController: viewController)
        let presenter = LoginViewPresenter(requestFactory: requestFactory,
                                          viewController: viewController,
                                          router: router)
        viewController.presenter = presenter
    }
}
