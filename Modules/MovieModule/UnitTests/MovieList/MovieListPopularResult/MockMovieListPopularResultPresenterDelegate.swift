//
//  MockMovieListPopularResultPresenterDelegate.swift
//  MovieModuleTests
//
//  Created by Yasin Akbas on 15.08.2022.
//  Copyright © 2022 com.yasinkbas. All rights reserved.
//

@testable import MovieModule

final class MockMovieListPopularResultPresenterDelegate: MovieListPopularResultPresenterDelegate {

    var invokedMovieListPopularResultFetchPopularMovies = false
    var invokedMovieListPopularResultFetchPopularMoviesCount = 0
    var invokedMovieListPopularResultFetchPopularMoviesParameters: (page: Int, Void)?
    var invokedMovieListPopularResultFetchPopularMoviesParametersList = [(page: Int, Void)]()

    func movieListPopularResultFetchPopularMovies(page: Int) {
        invokedMovieListPopularResultFetchPopularMovies = true
        invokedMovieListPopularResultFetchPopularMoviesCount += 1
        invokedMovieListPopularResultFetchPopularMoviesParameters = (page, ())
        invokedMovieListPopularResultFetchPopularMoviesParametersList.append((page, ()))
    }
}
