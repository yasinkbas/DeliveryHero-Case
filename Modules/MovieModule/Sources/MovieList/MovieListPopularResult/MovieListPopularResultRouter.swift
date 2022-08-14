//
//  MovieListPopularResultRouter.swift
//  MovieModule
//
//  Created by Yasin Akbas on 12.08.2022.
//  Copyright © 2022 com.yasinkbas. All rights reserved.
//

import UIKit

protocol MovieListPopularResultRouterInterface: AnyObject {
    func navigateToMovieDetail(with id: Int)
}

final class MovieListPopularResultRouter {
    static func createModule(arguments: MovieListPopularResultPresenterArguments) -> (MovieListPopularResultViewController, MovieListPopularResultModule) {
        let view = MovieListPopularResultViewController()
        let router = MovieListPopularResultRouter()
        let presenter = MovieListPopularResultPresenter(view: view, router: router, arguments: arguments)
        view.presenter = presenter
        return (view, presenter)
    }
}

// MARK: - MovieListPopularResultRouterInterface
extension MovieListPopularResultRouter: MovieListPopularResultRouterInterface { 
    func navigateToMovieDetail(with id: Int) {
        let viewController = MovieDetailRouter.createModule(arguments: .init(id: id))
        UIApplication.shared.keyWindow?.rootViewController?.present(viewController, animated: true)
    }
}

