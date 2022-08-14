//
//  MovieModule.swift
//  MovieModule
//
//  Created by Yasin Akbas on 10.08.2022.
//  Copyright © 2022 com.yasinkbas. All rights reserved.
//

import Foundation
import UIKit
import DependencyManagerKit

public class PersonModule {
    public init() {}
}

// MARK: - MovieModuleInterface
extension PersonModule: PersonModuleInterface {
    public func personDetailViewController(for id: Int) -> UIViewController {
        PersonDetailRouter.createModule(arguments: .init(id: id))
    }
}
