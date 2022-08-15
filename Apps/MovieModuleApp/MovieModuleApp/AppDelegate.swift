//
//  AppDelegate.swift
//  MovieModuleApp
//
//  Created by Yasin Akbas on 14.08.2022.
//

import UIKit
import MovieModule
import NetworkManagerKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Set APIKey
        NetworkConfigs.register(themoviedbApiKey: "<api_key>")
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = MovieModule().movieListViewController()
        window?.makeKeyAndVisible()
        return true
    }
}

