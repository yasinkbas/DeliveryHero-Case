//
//  MovieListSearchResultRouter.swift
//  MovieModule
//
//  Created by Yasin Akbas on 13.08.2022.
//  Copyright © 2022 com.yasinkbas. All rights reserved.
//

import UIKit
import DependencyManagerKit

protocol MovieListSearchResultRouterInterface: AnyObject {
    func navigateToProductDetail(with id: Int)
    func navigateToMovieDetail(with id: Int)
}

final class MovieListSearchResultRouter {
    @Dependency var personModule: PersonModuleInterface
    
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
    func navigateToProductDetail(with id: Int) {
        let viewController = personModule.personDetailViewController(for: id)
        UIApplication.shared.keyWindow?.rootViewController?.present(viewController, animated: true)
    }
    
    func navigateToMovieDetail(with id: Int) {
        let viewController = MovieDetailRouter.createModule(arguments: .init(id: id))
        UIApplication.shared.keyWindow?.rootViewController?.present(viewController, animated: true)
    }
}

