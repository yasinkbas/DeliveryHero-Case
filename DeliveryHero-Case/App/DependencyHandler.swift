//
//  DependencyHandler.swift
//  DeliveryHero-Case
//
//  Created by Yasin Akbas on 10.08.2022.
//  Copyright © 2022 com.yasinkbas.DeliveryHero-Case. All rights reserved.
//

import DependencyManagerKit
import MovieModule
import PersonModule

final class DependencyHandler {
    func registerDependencies() {
        DependencyEngine.shared.register(value: MovieModule(), for: MovieModuleInterface.self)
        DependencyEngine.shared.register(value: PersonModule(), for: PersonModuleInterface.self)
    }
}
