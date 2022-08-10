//
//  AppRouter.swift
//  DeliveryHero-Case
//
//  Created by Yasin Akbas on 10.08.2022.
//  Copyright © 2022 com.yasinkbas.DeliveryHero-Case. All rights reserved.
//

import UIKit
import DependencyManagerKit

final class AppRouter {
    @Dependency var movieModule: MovieModuleInterface
    
    let window: UIWindow?
    
    init(window: UIWindow?) {
        self.window = window
    }
    
    func initializeRootViewController() {
        let movieListViewController = movieModule.movieListViewController()
        window?.rootViewController = movieListViewController
        window?.makeKeyAndVisible()
    }
}
