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
        if userName != "" && password != "" {
            
            //check if such user is exist
            if registerNotifications(userName: userName) {
                let user = try! RealmProvider.get(User.self).filter("login CONTAINS[cd] %@",userName)
                let realm = try! Realm()
                try! realm.write{
                    
                    // change passsword for existing user
                    user.first?.setValue(password, forKey: "password")
                }
                
                let ac  = UIAlertController(title: "Message", message: "Password for your account succesfully changed", preferredStyle: .alert)
                let aa = UIAlertAction(title: "Ok", style: .default) { [weak self] _ in
                    UserDefaults.standard.set(true, forKey: "isLogin")
                    self?.router.goToMapViewController()
                }
                ac.addAction(aa)
                self.viewController.present(ac, animated: true, completion: nil)
            }  else {
                let user = User()
                user.login = userName
                user.password = password
                do {
                    let realm = try Realm()
                    print(realm.configuration.fileURL)
                    
                    //add new user to database
                    try! realm.write{
                        realm.add(user)
                    }
                    let ac  = UIAlertController(title: "Congratulation", message: "Your account is succesfully saved", preferredStyle: .alert)
                    let aa = UIAlertAction(title: "OK", style: .default){ [weak self] _ in
                        UserDefaults.standard.set(true, forKey: "isLogin")
                        self?.router.goToMapViewController()
                    }
                    ac.addAction(aa)
                    self.viewController.present(ac, animated: true, completion: nil)
                } catch {
                    print(error)
                }
            }
        } else {
            // if userName or password is empty
            let ac  = UIAlertController(title: "Warning", message: "To create an account you need to enter login and password", preferredStyle: .alert)
            let aa = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            ac.addAction(aa)
            self.viewController.present(ac, animated: true, completion: nil)
        }
        
    }
    
    func login(userName: String, password: String) {
        if loginNotifications(userName: userName, password: password){
            UserDefaults.standard.set(true, forKey: "isLogin")
            router.goToMapViewController()
        } else {
            let ac  = UIAlertController(title: "Warning", message: "Login or Password is incorrect", preferredStyle: .alert)
            let aa = UIAlertAction(title: "OK", style: .cancel){[weak self] _ in
                self?.viewController.clearTextfields()
                
            }
            ac.addAction(aa)
            self.viewController.present(ac, animated: true, completion: nil)
        }
    }
    
    private func registerNotifications(userName: String) -> Bool {
        if let _ = try? RealmProvider.get(User.self).filter("login CONTAINS[cd] %@",userName) {
            return false
        }
        return true
    }
    
    private func loginNotifications(userName: String, password: String) -> Bool {
        let user = try! RealmProvider.get(User.self).filter("login CONTAINS[cd] %@ AND password CONTAINS[cd] %@", userName, password)
        if !user.isEmpty {
            return true
        }
        return false
        
    }
    
}
