//
//  MockMovieListSearchResultPresenterDelegate.swift
//  MovieModuleTests
//
//  Created by Yasin Akbas on 15.08.2022.
//  Copyright © 2022 com.yasinkbas. All rights reserved.
//

@testable import MovieModule

final class MockMovieListSearchResultPresenterDelegate: MovieListSearchResultPresenterDelegate {

    var invokedMovieListSearchResultSearchMovies = false
    var invokedMovieListSearchResultSearchMoviesCount = 0
    var invokedMovieListSearchResultSearchMoviesParameters: (page: Int, query: String)?
    var invokedMovieListSearchResultSearchMoviesParametersList = [(page: Int, query: String)]()

    func movieListSearchResultSearchMovies(page: Int, query: String) {
        invokedMovieListSearchResultSearchMovies = true
        invokedMovieListSearchResultSearchMoviesCount += 1
        invokedMovieListSearchResultSearchMoviesParameters = (page, query)
        invokedMovieListSearchResultSearchMoviesParametersList.append((page, query))
    }

    var invokedMovieListSearchResultSearchGenreMovies = false
    var invokedMovieListSearchResultSearchGenreMoviesCount = 0
    var invokedMovieListSearchResultSearchGenreMoviesParameters: (page: Int, query: String)?
    var invokedMovieListSearchResultSearchGenreMoviesParametersList = [(page: Int, query: String)]()

    func movieListSearchResultSearchGenreMovies(page: Int, query: String) {
        invokedMovieListSearchResultSearchGenreMovies = true
        invokedMovieListSearchResultSearchGenreMoviesCount += 1
        invokedMovieListSearchResultSearchGenreMoviesParameters = (page, query)
        invokedMovieListSearchResultSearchGenreMoviesParametersList.append((page, query))
    }

    var invokedMovieListSearchResultSearchPeople = false
    var invokedMovieListSearchResultSearchPeopleCount = 0
    var invokedMovieListSearchResultSearchPeopleParameters: (page: Int, query: String)?
    var invokedMovieListSearchResultSearchPeopleParametersList = [(page: Int, query: String)]()

    func movieListSearchResultSearchPeople(page: Int, query: String) {
        invokedMovieListSearchResultSearchPeople = true
        invokedMovieListSearchResultSearchPeopleCount += 1
        invokedMovieListSearchResultSearchPeopleParameters = (page, query)
        invokedMovieListSearchResultSearchPeopleParametersList.append((page, query))
    }
}
