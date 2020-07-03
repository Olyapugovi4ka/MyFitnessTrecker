//
//  SceneDelegate.swift
//  MyFitnessTrecker
//
//  Created by ios_Dev on 10.06.2020.
//  Copyright © 2020 ios_Dev. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var visualEffectView = UIVisualEffectView()

    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        let launchViewController = LaunchViewController()
        let navigation = UINavigationController(rootViewController: launchViewController)
        navigation.navigationBar.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.0)
        navigation.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigation.navigationBar.shadowImage = UIImage()
        navigation.navigationBar.isTranslucent = true
        navigation.navigationBar.isUserInteractionEnabled = false
        
        
        
        window?.rootViewController = navigation
        window?.makeKeyAndVisible()
    }
    
    func sceneDidDisconnect(_ scene: UIScene) {
        
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        
    }

    func sceneWillResignActive(_ scene: UIScene) {
        if !self.visualEffectView.isDescendant(of: self.window!) {
            let blurEffect = UIBlurEffect(style: .light)
            self.visualEffectView = UIVisualEffectView(effect: blurEffect)
            self.visualEffectView.frame = (self.window?.bounds)!
            self.window?.addSubview(self.visualEffectView)
        }
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        self.visualEffectView.removeFromSuperview()
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        
    }


}

