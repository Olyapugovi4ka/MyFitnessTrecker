//
//  LoginViewController.swift
//  MyFitnessTrecker
//
//  Created by ios_Dev on 10.06.2020.
//  Copyright © 2020 ios_Dev. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    private let loginView = LoginView()
    
    var presenter: LoginViewPresenterProtocol?
    var assembler: LoginViewAssembly!
    
    override func loadView() {
        self.view = loginView
        loginView.loginViewDelegate = self
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        assembler.assembly()
       
    }
   
}

extension LoginViewController: LoginViewDelegate {
    func goToMapViewController() {
         print(#function)
        presenter?.goToMapViewController()
    }
    
    
}
