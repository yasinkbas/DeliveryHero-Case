//
//  MockMovieListSearchResultRouter.swift
//  MovieModuleTests
//
//  Created by Yasin Akbas on 15.08.2022.
//  Copyright © 2022 com.yasinkbas. All rights reserved.
//

@testable import MovieModule

final class MockMovieListSearchResultRouter: MovieListSearchResultRouterInterface {

    var invokedNavigateToPersonDetail = false
    var invokedNavigateToPersonDetailCount = 0
    var invokedNavigateToPersonDetailParameters: (id: Int, Void)?
    var invokedNavigateToPersonDetailParametersList = [(id: Int, Void)]()

    func navigateToPersonDetail(with id: Int) {
        invokedNavigateToPersonDetail = true
        invokedNavigateToPersonDetailCount += 1
        invokedNavigateToPersonDetailParameters = (id, ())
        invokedNavigateToPersonDetailParametersList.append((id, ()))
    }

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
