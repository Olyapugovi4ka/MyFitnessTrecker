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
}

class LoginView: UIView {
    weak var loginViewDelegate: LoginViewDelegate?
    lazy var goToMapButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Log In", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .gray
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 15
        button.layer.masksToBounds = true
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
        mapZoomAnimateWithDelay()
    }
    
    func configureUI() {
        addGoToMapButton()
        addBackground()
    }
    
    func addGoToMapButton() {
        addSubview(goToMapButton)
        
      // goToMapButton constraints
        goToMapButton.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        goToMapButton.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        goToMapButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        goToMapButton.widthAnchor.constraint(equalToConstant: 75).isActive = true
        goToMapButton.addTarget(self, action:#selector(goToMapButtonTapped), for: .touchUpInside)
    }
    
    @objc func goToMapButtonTapped() {
        loginViewDelegate?.goToMapViewController()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
   func mapZoomAnimateWithDelay() {
    UIView.animate(withDuration: 2) {
        self.goToMapButton.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
    }
   
}
}
