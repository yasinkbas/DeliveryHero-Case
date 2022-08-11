//
//  MovieListPopularResultRouter.swift
//  MovieModule
//
//  Created by Yasin Akbas on 12.08.2022.
//  Copyright © 2022 com.yasinkbas. All rights reserved.
//

import UIKit

protocol MovieListPopularResultRouterInterface: AnyObject {
    
}

final class MovieListPopularResultRouter {
    static func createModule(arguments: MovieListPopularResultPresenterArguments) -> MovieListPopularResultViewController {
        let view = MovieListPopularResultViewController()
        let router = MovieListPopularResultRouter()
        let presenter = MovieListPopularResultPresenter(view: view, router: router, arguments: arguments)
        view.presenter = presenter
        return view
    }
}

// MARK: - MovieListPopularResultRouterInterface
extension MovieListPopularResultRouter: MovieListPopularResultRouterInterface { 
    
}

