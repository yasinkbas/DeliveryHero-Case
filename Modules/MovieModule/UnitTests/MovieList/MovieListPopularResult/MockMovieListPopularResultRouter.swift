//
//  MockMovieListPopularResultRouter.swift
//  MovieModule
//
//  Created by Yasin Akbas on 15.08.2022.
//  Copyright © 2022 com.yasinkbas. All rights reserved.
//

@testable import MovieModule

final class MockMovieListPopularResultRouter: MovieListPopularResultRouterInterface {

    var invokedNavigateToMovieDetail = false
    var invokedNavigateToMovieDetailCount = 0
    var invokedNavigateToMovieDetailParameters: (id: Int, Void)?
    var invokedNavigateToMovieDetailParametersList = [(id: Int, Void)]()

    func navigateToMovieDetail(with id: Int) {
        invokedNavigateToMovieDetail = true
        invokedNavigateToMovieDetailCount += 1
        invokedNavigateToMovieDetailParameters = (id, ())
        invokedNavigateToMovieDetailParametersList.append((id, ()))
    }
}
