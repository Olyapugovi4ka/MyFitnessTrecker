//
//  LoginViewController.swift
//  MyFitnessTrecker
//
//  Created by ios_Dev on 10.06.2020.
//  Copyright © 2020 ios_Dev. All rights reserved.
//

import UIKit
import RxSwift
import RealmSwift

class LoginViewController: UIViewController, UINavigationControllerDelegate {
    
    private let loginView = LoginView()
    private lazy var isKeyBoardIsOnScreen: Bool = {
        return false
    }()
    
    var presenter: LoginViewPresenterProtocol?
    var assembler: LoginViewAssembly!
    
   
  
    
    override func loadView() {
        self.view = loginView
        loginView.loginViewDelegate = self
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        assembler.assembly()
        configureLoginBindings()
        print("LoginView init")
    }
    
    //MARK: Controller Lifecycle
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = true
        loginView.scrollView.isScrollEnabled = false
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWasShown(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWasHidden(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        //MARK: User's tap
        let tapGR = UITapGestureRecognizer( target: self, action: #selector(hideKeyBoard))
        loginView.scrollView.addGestureRecognizer(tapGR)
    }
    
    //MARK: Controller Lifecycle
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    //MARK: Private API
    //MARK: Keyboard ON
    @objc private func keyboardWasShown(notification: Notification) {
        isKeyBoardIsOnScreen = true
        loginView.scrollView.isScrollEnabled = true
        let info = notification.userInfo as NSDictionary?
        let keyboardSize = (info?.value(forKey: UIResponder.keyboardFrameEndUserInfoKey) as! NSValue).cgRectValue.size
        let contentsInsets = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height, right: 0)
        
        loginView.scrollView.contentInset = contentsInsets
        loginView.scrollView.scrollIndicatorInsets = contentsInsets
    }
    
    //MARK: Keyboard OFF
    @objc private func keyboardWasHidden(notification: Notification) {
        isKeyBoardIsOnScreen = false
        loginView.scrollView.isScrollEnabled = false
        let contentsInsets = UIEdgeInsets.zero
        
        loginView.scrollView.contentInset = contentsInsets
        loginView.scrollView.scrollIndicatorInsets = contentsInsets
    }
    
    //MARK: How to hide keyboard
    @objc private func hideKeyBoard() {
        loginView.scrollView.endEditing(true)
    }
    
    //to clear textFields
    func clearTextfields() {
        loginView.setClearTextFields()
    }
    
    func addAvatar() {
        let imagePickerController = ImagePickerController()
        imagePickerController.imagePickerControllerDelegate = self
        present(imagePickerController, animated: true)
    }
}

extension LoginViewController: LoginViewDelegate {
    func registration(with userName: String, and password: String) {
        presenter?.register(userName: userName, password: password)
        
    }
    
    func restorePassword() {
        print(#function)
        //TO DO: restore password
        
    }
    
    
    func login(with userName: String, and password: String) {
        presenter?.login(userName: userName, password: password)
    }
   
    //MARK: Rx
    func configureLoginBindings() {
    _ = Observable.combineLatest(loginView.userLoginTextField.rx.text, loginView.passwordTextField.rx.text)
            .map { login, password in
                return !(login ?? "").isEmpty && (password ?? "").count >= 6
        }
        .bind { [weak self] inputFilled in
            self?.loginView.goToMapButton.isEnabled = inputFilled
            self?.loginView.goToMapButton.backgroundColor = inputFilled ? #colorLiteral(red: 0.3145284653, green: 0.6868624687, blue: 0.2808583081, alpha: 1) : .gray
        }
    }
    
    
}
extension LoginViewController: ImagePickerControllerDelegate {
    func goToPhotoViewController() {
        self.presenter?.goToPhotoViewController()
    }
     
}
