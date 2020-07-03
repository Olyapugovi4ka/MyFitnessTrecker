//
//  LoginViewPresenter.swift
//  StorageLLC
//
//  Created by ios_Dev on 10.06.2020.
//  Copyright © 2020 ios_Dev. All rights reserved.
//

import Foundation
import RealmSwift

protocol LoginViewPresenterProtocol {
    func login(userName: String, password: String)
    func register(userName: String, password: String)
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
    func register(userName: String, password: String) {
        
        // check if userName and password is not empty
        if Validator.isFilled(login: userName, password: password) {
            guard Validator.isPasswordLengthIsRight(password: password) else {
                return self.viewController.showAlert(title: "Warning", message: "Password is to be more or equal 6 simbols")
            }
            //check if such user is exist
            if registerNotifications(userName: userName) {
                let user = try! RealmProvider.get(User.self).filter("login CONTAINS[cd] %@",userName)
                let realm = try! Realm()
                try! realm.write{

                    // change passsword for existing user
                    user.first?.setValue(password, forKey: "password")
                }
                self.viewController.showAlert(title: "Message", message: "Password for your account succesfully changed") { [weak self] _ in
                UserDefaults.standard.set(true, forKey: "isLogin")
                self?.router.goToMapViewController()
                }
            }  else {
                let user = User()
                user.login = userName
                user.password = password
                try! RealmProvider.save(item: user)
                self.viewController.showAlert(title: "Congratulation", message: "Your account is succesfully saved") { [weak self] _ in
                    UserDefaults.standard.set(true, forKey: "isLogin")
                    self?.router.goToMapViewController()
                }
            }
        } else {
            // if userName or password is empty
            self.viewController.showAlert(title: "Warning", message: "To create an account you need to enter login and password")
        }
    }
    
    func login(userName: String, password: String) {
        if loginNotifications(userName: userName, password: password){
            UserDefaults.standard.set(true, forKey: "isLogin")
            router.goToMapViewController()
        } else {
            self.viewController.showAlert(title: "Warning", message: "Login or Password is incorrect") { [weak self] _ in
            self?.viewController.clearTextfields()
            }
        }
    }
    
    // check an existance of user with such login
    private func registerNotifications(userName: String) -> Bool {
        if let _ = try? RealmProvider.get(User.self).filter("login CONTAINS[cd] %@",userName) {
            return false
        }
        return true
    }
    
    // check an existance of user with such login and password
    private func loginNotifications(userName: String, password: String) -> Bool {
        let user = try! RealmProvider.get(User.self).filter("login CONTAINS[cd] %@ AND password CONTAINS[cd] %@", userName, password)
        if !user.isEmpty {
            return true
        }
        return false
    }
}
