//
//  LaunchViewController.swift
//  MyFitnessTrecker
//
//  Created by ios_Dev on 23.06.2020.
//  Copyright © 2020 ios_Dev. All rights reserved.
//

import UIKit

class LaunchViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        if UserDefaults.standard.bool(forKey: "isLogin") {
            let loginViewController = LoginViewController()
            loginViewController.assembler = LoginViewAssembly(viewController: loginViewController)
            navigationController?.pushViewController(loginViewController, animated: true)
        } else {
            let mapViewController = MapViewController()
            mapViewController.assembler = MapViewAssembly(viewController: mapViewController)
            navigationController?.pushViewController(mapViewController, animated: true)
        }
    }
    

}
