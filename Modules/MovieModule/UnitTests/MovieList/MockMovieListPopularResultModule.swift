//
//  MockMovieListPopularResultModule.swift
//  MovieModuleTests
//
//  Created by Yasin Akbas on 15.08.2022.
//  Copyright © 2022 com.yasinkbas. All rights reserved.
//

@testable import MovieModule

final class MockMovieListPopularResultModule: MovieListPopularResultModule {

    var invokedAddNewMovies = false
    var invokedAddNewMoviesCount = 0
    var invokedAddNewMoviesParameters: (response: MovieListAPIResponse, Void)?
    var invokedAddNewMoviesParametersList = [(response: MovieListAPIResponse, Void)]()

    func addNewMovies(response: MovieListAPIResponse) {
        invokedAddNewMovies = true
        invokedAddNewMoviesCount += 1
        invokedAddNewMoviesParameters = (response, ())
        invokedAddNewMoviesParametersList.append((response, ()))
    }
}
