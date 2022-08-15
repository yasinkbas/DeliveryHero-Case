//
//  MockMovieListSearchResultView.swift
//  MovieModuleTests
//
//  Created by Yasin Akbas on 15.08.2022.
//  Copyright © 2022 com.yasinkbas. All rights reserved.
//

import Foundation
@testable import MovieModule

final class MockMovieListSearchResultCellView: MovieListSearchResultCellViewInterface {

    var invokedPrepareUI = false
    var invokedPrepareUICount = 0

    func prepareUI() {
        invokedPrepareUI = true
        invokedPrepareUICount += 1
    }

    var invokedSetTitleLabel = false
    var invokedSetTitleLabelCount = 0
    var invokedSetTitleLabelParameters: (text: String, Void)?
    var invokedSetTitleLabelParametersList = [(text: String, Void)]()

    func setTitleLabel(text: String) {
        invokedSetTitleLabel = true
        invokedSetTitleLabelCount += 1
        invokedSetTitleLabelParameters = (text, ())
        invokedSetTitleLabelParametersList.append((text, ()))
    }
}
