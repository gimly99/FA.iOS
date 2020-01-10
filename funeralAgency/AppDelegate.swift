//
//  AppDelegate.swift
//  funeralAgency
//
//  Created by user on 20/12/2019.
//  Copyright © 2019 user. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let window = UIWindow()
        self.window = window
        window.rootViewController = AuthView.viewController(viewControllerClass: AuthView.self)
        window.makeKeyAndVisible()
        return true
    }
}

