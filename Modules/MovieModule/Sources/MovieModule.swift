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

public class MovieModule {
    public init() {}
}

// MARK: - MovieModuleInterface
extension MovieModule: MovieModuleInterface {
    public func movieListViewController() -> UIViewController {
        // TODO: return movieListViewController
        let dummyViewController = UIViewController()
        dummyViewController.view.backgroundColor = .red
        return dummyViewController
    }
}
