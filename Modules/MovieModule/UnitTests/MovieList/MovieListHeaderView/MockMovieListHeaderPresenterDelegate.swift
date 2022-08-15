//
//  MockMovieListHeaderPresenterDelegate.swift
//  MovieModule
//
//  Created by Yasin Akbas on 15.08.2022.
//  Copyright © 2022 com.yasinkbas. All rights reserved.
//

@testable import MovieModule

final class MockMovieListHeaderPresenterDelegate: MovieListHeaderPresenterDelegate {

    var invokedMovieListHeaderSearchButtonTapped = false
    var invokedMovieListHeaderSearchButtonTappedCount = 0
    var invokedMovieListHeaderSearchButtonTappedParameters: (searchText: String, Void)?
    var invokedMovieListHeaderSearchButtonTappedParametersList = [(searchText: String, Void)]()

    func movieListHeaderSearchButtonTapped(searchText: String) {
        invokedMovieListHeaderSearchButtonTapped = true
        invokedMovieListHeaderSearchButtonTappedCount += 1
        invokedMovieListHeaderSearchButtonTappedParameters = (searchText, ())
        invokedMovieListHeaderSearchButtonTappedParametersList.append((searchText, ()))
    }

    var invokedMovieListHeaderShrinkButtonTapped = false
    var invokedMovieListHeaderShrinkButtonTappedCount = 0

    func movieListHeaderShrinkButtonTapped() {
        invokedMovieListHeaderShrinkButtonTapped = true
        invokedMovieListHeaderShrinkButtonTappedCount += 1
    }
}
