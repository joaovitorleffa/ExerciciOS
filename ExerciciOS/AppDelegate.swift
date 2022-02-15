//
//  AppDelegate.swift
//  ExerciciOS
//
//  Created by joaovitor on 14/02/22.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = WorkoutListViewController()
        window?.makeKeyAndVisible()

        return true
    }
    
}

