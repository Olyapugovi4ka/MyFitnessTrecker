//
//  LoginView.swift
//  MyFitnessTrecker
//
//  Created by ios_Dev on 10.06.2020.
//  Copyright © 2020 ios_Dev. All rights reserved.
//

import UIKit

protocol LoginViewDelegate: class {
    func goToMapViewController()
    func restorePassword()
    func registration()
}

class LoginView: UIView {
    weak var loginViewDelegate: LoginViewDelegate?
    var holderVieHeight: NSLayoutDimension?
    
     // first layer
       lazy var scrollView: UIScrollView = {
           let view = UIScrollView()
           view.translatesAutoresizingMaskIntoConstraints = false
           return view
       }()
       
       lazy var containerView: UIView = {
           let view = UIView()
           view.translatesAutoresizingMaskIntoConstraints = false
           return view
       }()
    
    // second layer
    lazy var holderView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = #colorLiteral(red: 0.9685428739, green: 0.9686816335, blue: 0.9685124755, alpha: 1)
        //view.alpha = 0.9
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.5
        view.layer.shadowRadius = 8
        view.layer.shadowOffset = CGSize.zero
        
        view.layer.cornerRadius = 30
        // view.layer.masksToBounds = true
        return view
    }()
    
    lazy var registerLabel: UILabel = {
        let label = UILabel()
        label.text = "Don't have an account ?"
        label.font = label.font.withSize(self.frame.height * 0.046)
        label.textColor = #colorLiteral(red: 0.1921363771, green: 0.1921699047, blue: 0.1921290755, alpha: 1)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var registerButton: UIButton = {
        let button = UIButton()
        button.setTitle("REGISTER", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        button.setTitleColor(#colorLiteral(red: 0.3145284653, green: 0.6868624687, blue: 0.2808583081, alpha: 1), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    //third layer
    lazy var userLoginTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
            textField.translatesAutoresizingMaskIntoConstraints = false
        textField.attributedPlaceholder = NSAttributedString(string: "User Name or E-mail", attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 80.0/255.0, green: 175.0/255.0, blue: 72.0/255.0, alpha: 0.75)])
        textField.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        return textField
    }()
    
    lazy var passwordTextField: UITextField = {
        let textField = UITextField()
       textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.attributedPlaceholder = NSAttributedString(string: "Password")
        textField.isSecureTextEntry = true
        return textField
    }()
    
    lazy var forgotPasswordButton: UIButton = {
        let button = UIButton()
        button.setTitle("In case ou forgot password ?", for: .normal)
        button.setTitleColor(#colorLiteral(red: 0.3145284653, green: 0.6868624687, blue: 0.2808583081, alpha: 1), for: .normal)
        button.contentHorizontalAlignment = .center
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var goToMapButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Log In", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .gray
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 15
        button.layer.masksToBounds = true
        button.addTarget(self, action:#selector(goToMapButtonTapped), for: .touchUpInside)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
        //mapZoomAnimateWithDelay()
    }
    
    func configureUI() {
        overlayFirstSubview()
        overlaySecondSubview()
        overlayThirdSubview()
    }
    
    func overlayFirstSubview() {
        addBackground()
        self.addSubview(scrollView)
        scrollView.addSubview(containerView)
       
        // scrollView constraints
        scrollView.anchor(top: self.topAnchor, leading: self.leadingAnchor, bottom: self.bottomAnchor, trailing: self.trailingAnchor, padding: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
        print(scrollView.bounds.size.width)
               print(scrollView.bounds.size.height)
        // containerView constraints
        containerView.anchor(top: scrollView.topAnchor, leading: scrollView.leadingAnchor, bottom: scrollView.bottomAnchor, trailing: scrollView.trailingAnchor, padding: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
        containerView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.size.width).isActive = true
        containerView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.size.height).isActive = true
        

    }
    
     func overlaySecondSubview() {
        containerView.addSubview(holderView)
        
        holderView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
        holderView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        holderView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.size.width - 40).isActive = true
        holderView.heightAnchor.constraint(equalToConstant: 300).isActive = true
        
    }
    
      func overlayThirdSubview() {

        let registerStack = UIStackView(arrangedSubviews: [registerLabel, registerButton])
        registerStack.translatesAutoresizingMaskIntoConstraints = false
        registerStack.axis = .vertical
        registerStack.distribution = .fillProportionally
//
//        registerStack.anchor(top: nil, leading: holderView.leadingAnchor, bottom: holderView.bottomAnchor, trailing: holderView.trailingAnchor, padding: .init(top: 777, left: 20, bottom: 50, right: 20))
        //registerStack.heightAnchor.constraint(equalToConstant: 50).isActive = true
        let containerForHolder = UIStackView(arrangedSubviews: [userLoginTextField,passwordTextField, forgotPasswordButton, goToMapButton,registerStack ])
        containerForHolder.translatesAutoresizingMaskIntoConstraints = false
        containerForHolder.spacing = 10
        containerForHolder.axis = .vertical
        containerForHolder.distribution = .fillEqually
       // goToMapButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
       // forgotPasswordButton.heightAnchor.constraint(equalToConstant: 20).isActive = true

        holderView.addSubview(containerForHolder)
        containerForHolder.topAnchor.constraint(equalTo: holderView.topAnchor, constant: 20).isActive = true
        containerForHolder.leadingAnchor.constraint(equalTo: holderView.leadingAnchor, constant:  16).isActive = true
        containerForHolder.trailingAnchor.constraint(equalTo: holderView.trailingAnchor, constant:  -16).isActive = true
        containerForHolder.bottomAnchor.constraint(equalTo: holderView.bottomAnchor, constant:  -20).isActive = true
//        holderVieHeight = containerForHolder.heightAnchor
//        holderView.heightAnchor.constraint(equalTo: holderVieHeight!,constant: 40).isActive = true


    }
    
    @objc func goToMapButtonTapped() {
        loginViewDelegate?.goToMapViewController()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
//   func mapZoomAnimateWithDelay() {
//    UIView.animate(withDuration: 2) {
//        self.goToMapButton.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
//    }
//
//}
}
