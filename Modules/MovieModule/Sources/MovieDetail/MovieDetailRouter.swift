//
//  MovieDetailRouter.swift
//  MovieModule
//
//  Created by Yasin Akbas on 15.08.2022.
//  Copyright © 2022 com.yasinkbas. All rights reserved.
//

import UIKit

protocol MovieDetailRouterInterface: AnyObject {
    
}

final class MovieDetailRouter {
    static func createModule(arguments: MovieDetailPresenterArguments) -> MovieDetailViewController {
        let view = MovieDetailViewController()
        let interactor = MovieDetailInteractor()
        let router = MovieDetailRouter()
        let presenter = MovieDetailPresenter(view: view, router: router, interactor: interactor, arguments: arguments)
        view.presenter = presenter
        interactor.output = presenter
        return view
    }
}

// MARK: - MovieDetailRouterInterface
extension MovieDetailRouter: MovieDetailRouterInterface { 
    
}

