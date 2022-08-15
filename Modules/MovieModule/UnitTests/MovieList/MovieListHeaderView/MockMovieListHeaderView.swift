//
//  MockMovieListHeaderView.swift
//  MovieModule
//
//  Created by Yasin Akbas on 15.08.2022.
//  Copyright © 2022 com.yasinkbas. All rights reserved.
//

@testable import MovieModule

final class MockMovieListHeaderView: MovieListHeaderViewInterface {

    var invokedPrepareUI = false
    var invokedPrepareUICount = 0

    func prepareUI() {
        invokedPrepareUI = true
        invokedPrepareUICount += 1
    }

    var invokedShowSearchTextField = false
    var invokedShowSearchTextFieldCount = 0

    func showSearchTextField() {
        invokedShowSearchTextField = true
        invokedShowSearchTextFieldCount += 1
    }

    var invokedHideSearchTextField = false
    var invokedHideSearchTextFieldCount = 0

    func hideSearchTextField() {
        invokedHideSearchTextField = true
        invokedHideSearchTextFieldCount += 1
    }

    var invokedSetTextField = false
    var invokedSetTextFieldCount = 0
    var invokedSetTextFieldParameters: (text: String, Void)?
    var invokedSetTextFieldParametersList = [(text: String, Void)]()

    func setTextField(text: String) {
        invokedSetTextField = true
        invokedSetTextFieldCount += 1
        invokedSetTextFieldParameters = (text, ())
        invokedSetTextFieldParametersList.append((text, ()))
    }
}
