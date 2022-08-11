//
//  MovieListRouter.swift
//  MovieModule
//
//  Created by Yasin Akbas on 11.08.2022.
//  Copyright © 2022 com.yasinkbas. All rights reserved.
//

import UIKit

protocol MovieListRouterInterface: AnyObject {
    
}

final class MovieListRouter {
    static func createModule() -> MovieListViewController {
        let view = MovieListViewController()
        let interactor = MovieListInteractor()
        let router = MovieListRouter()
        let presenter = MovieListPresenter(view: view, router: router, interactor: interactor)
        view.presenter = presenter
        interactor.output = presenter
        return view
    }
}

// MARK: - MovieListRouterInterface
extension MovieListRouter: MovieListRouterInterface { 
    
}

