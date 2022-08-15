//
//  MockMovieListInteractor.swift
//  MovieModuleTests
//
//  Created by Yasin Akbas on 15.08.2022.
//  Copyright © 2022 com.yasinkbas. All rights reserved.
//

@testable import MovieModule

final class MockMovieListInteractor: MovieListInteractorInterface {

    var invokedFetchPopularMovies = false
    var invokedFetchPopularMoviesCount = 0
    var invokedFetchPopularMoviesParameters: (page: Int, Void)?
    var invokedFetchPopularMoviesParametersList = [(page: Int, Void)]()

    func fetchPopularMovies(page: Int) {
        invokedFetchPopularMovies = true
        invokedFetchPopularMoviesCount += 1
        invokedFetchPopularMoviesParameters = (page, ())
        invokedFetchPopularMoviesParametersList.append((page, ()))
    }

    var invokedFetchMovieGenres = false
    var invokedFetchMovieGenresCount = 0

    func fetchMovieGenres() {
        invokedFetchMovieGenres = true
        invokedFetchMovieGenresCount += 1
    }

    var invokedSearchMovies = false
    var invokedSearchMoviesCount = 0
    var invokedSearchMoviesParameters: (page: Int, query: String)?
    var invokedSearchMoviesParametersList = [(page: Int, query: String)]()

    func searchMovies(page: Int, query: String) {
        invokedSearchMovies = true
        invokedSearchMoviesCount += 1
        invokedSearchMoviesParameters = (page, query)
        invokedSearchMoviesParametersList.append((page, query))
    }

    var invokedSearchPeople = false
    var invokedSearchPeopleCount = 0
    var invokedSearchPeopleParameters: (page: Int, query: String)?
    var invokedSearchPeopleParametersList = [(page: Int, query: String)]()

    func searchPeople(page: Int, query: String) {
        invokedSearchPeople = true
        invokedSearchPeopleCount += 1
        invokedSearchPeopleParameters = (page, query)
        invokedSearchPeopleParametersList.append((page, query))
    }

    var invokedSearchGenreMovies = false
    var invokedSearchGenreMoviesCount = 0
    var invokedSearchGenreMoviesParameters: (page: Int, genreId: Int)?
    var invokedSearchGenreMoviesParametersList = [(page: Int, genreId: Int)]()

    func searchGenreMovies(page: Int, genreId: Int) {
        invokedSearchGenreMovies = true
        invokedSearchGenreMoviesCount += 1
        invokedSearchGenreMoviesParameters = (page, genreId)
        invokedSearchGenreMoviesParametersList.append((page, genreId))
    }
}
