//
//  MovieListSearchResultRouter.swift
//  MovieModule
//
//  Created by Yasin Akbas on 13.08.2022.
//  Copyright © 2022 com.yasinkbas. All rights reserved.
//

import UIKit

protocol MovieListSearchResultRouterInterface: AnyObject {
    
}

final class MovieListSearchResultRouter {
    static func createModule(arguments: MovieListSearchResultPresenterArguments) -> (MovieListSearchResultViewController, MovieListSearchResultModule) {
        let view = MovieListSearchResultViewController()
        let router = MovieListSearchResultRouter()
        let presenter = MovieListSearchResultPresenter(view: view, router: router, arguments: arguments)
        view.presenter = presenter
        return (view, presenter)
    }
}

// MARK: - MovieListSearchResultRouterInterface
extension MovieListSearchResultRouter: MovieListSearchResultRouterInterface { 
    
}

