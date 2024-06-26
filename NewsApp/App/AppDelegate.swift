//
//  AppDelegate.swift
//  NewsApp
//
//  Created by Даниил Сивожелезов on 04.06.2024.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        if let window = window {
            let tabBar = TabBarController()
            window.rootViewController = tabBar
            window.makeKeyAndVisible()
        }
        
        return true
    }
}

