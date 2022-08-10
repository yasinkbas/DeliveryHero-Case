//
//  AppContainer.swift
//  DeliveryHero-Case
//
//  Created by Yasin Akbas on 10.08.2022.
//  Copyright © 2022 com.yasinkbas.DeliveryHero-Case. All rights reserved.
//

import UIKit
import NetworkManagerKit
import UILab
import NLab

final class AppContainer {
    let router: AppRouter
    let window: UIWindow?
    
    init(window: UIWindow?) {
        self.window = window
        router = AppRouter(window: window)
        configureNetworkService()
        configureUILab()
        
        DependencyHandler().registerDependencies()
    }
    
    private func configureNetworkService() {
        struct APIKeys: Decodable {
            let themoviedb: String
        }
//        let response: Response = try! PropertyListParser.read(fileName: "APIKeys")
//        NetworkConfigs.register(placesApiKey: response.placesApiKey)
    }
    
    private func configureUILab() {
        UILab.Settings.debugMonitoringType = .verbose
    }
}
