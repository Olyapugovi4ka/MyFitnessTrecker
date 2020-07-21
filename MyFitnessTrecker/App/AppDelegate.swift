//
//  AppDelegate.swift
//  MyFitnessTrecker
//
//  Created by ios_Dev on 10.06.2020.
//  Copyright © 2020 ios_Dev. All rights reserved.
//

import UIKit
import GoogleMaps
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        GMSServices.provideAPIKey("AIzaSyBygRC_rjcAUlO17hsQodpxYgWtjFD508E")
        
        let center = UNUserNotificationCenter.current()
        center.delegate = self
        
        center.getNotificationSettings { setting in
            switch setting.authorizationStatus {
            case .authorized:
                print("Есть разрешение")
                self.sendNotify(content: self.makeNotifyContent(), trigger: self.makeNotifyTrigger())
            
            case .denied:
                print("Нет разрешения")
            case .notDetermined:
                center.requestAuthorization(options: [.alert,.sound,.badge]) { (state, error) in
                           if state {
                               print("Разрешение получено")
                           } else {
                               print("Разрешение не получено")
                           }
                       }
            case .provisional:
                print()
            @unknown default:
                fatalError()
            }
        }
       
        return true
    }
    
    func makeNotifyContent() -> UNNotificationContent {
        let content = UNMutableNotificationContent()
        
        content.badge = 1
        content.title = "Привет!"
        content.subtitle = "Запусти меня!"
        content.body = "Пора запустить приложение"
        return content
    }
    
    func makeNotifyTrigger() -> UNNotificationTrigger {
        return UNTimeIntervalNotificationTrigger(timeInterval: 1800, repeats: false)
    }
    
    func sendNotify(content: UNNotificationContent, trigger: UNNotificationTrigger) {
        let request = UNNotificationRequest(identifier: "alert", content: content, trigger: trigger)
        
         let center = UNUserNotificationCenter.current()
        center.add(request) { (error) in
            print(error?.localizedDescription)
        }
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        if response.notification.request.identifier == "alert" {
            print("Loaded")
            completionHandler()
        }
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
    }


}

