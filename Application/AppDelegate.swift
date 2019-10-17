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

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        window = UIWindow(frame: UIScreen.main.bounds)
        
        let app = AppCoordinator(window: self.window)
        app.start()
        
        return true
    }

    

}

