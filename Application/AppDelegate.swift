//
//  AppDelegate.swift
//  GithubIssue
//
//  Created by nhat on 10/16/19.
//  Copyright © 2019 nhat. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    private var appCoordinator: AppCoordinator!

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        UserDefaults.standard.setValue(false, forKey:"_UIConstraintBasedLayoutLogUnsatisfiable")

        
        window = UIWindow(frame: UIScreen.main.bounds)
        
        appCoordinator = AppCoordinator(window: window)
        
        appCoordinator.start()
        
        return true
    }

    

}

