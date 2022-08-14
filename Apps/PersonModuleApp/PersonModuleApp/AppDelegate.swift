//
//  AppDelegate.swift
//  PersonModuleApp
//
//  Created by Yasin Akbas on 15.08.2022.
//

import UIKit
import PersonModule

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = PersonModule().personDetailViewController(for: 1)
        window?.makeKeyAndVisible()
        return true
    }
}

