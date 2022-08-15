//
//  MockMovieDetailView.swift
//  MovieModule
//
//  Created by Yasin Akbas on 15.08.2022.
//  Copyright © 2022 com.yasinkbas. All rights reserved.
//

import CommonViewsKit
import UIKit
@testable import MovieModule

final class MockMovieDetailView: MovieDetailViewInterface {

    var invokedEmptyViewArgumentsGetter = false
    var invokedEmptyViewArgumentsGetterCount = 0
    var stubbedEmptyViewArguments: EmptyViewPresenterArguments!

    var emptyViewArguments: EmptyViewPresenterArguments {
        invokedEmptyViewArgumentsGetter = true
        invokedEmptyViewArgumentsGetterCount += 1
        return stubbedEmptyViewArguments
    }

    var invokedEmptyViewContainerViewGetter = false
    var invokedEmptyViewContainerViewGetterCount = 0
    var stubbedEmptyViewContainerView: UIView!

    var emptyViewContainerView: UIView {
        invokedEmptyViewContainerViewGetter = true
        invokedEmptyViewContainerViewGetterCount += 1
        return stubbedEmptyViewContainerView
    }

    var invokedEmptyViewPaddingsGetter = false
    var invokedEmptyViewPaddingsGetterCount = 0
    var stubbedEmptyViewPaddings: UIEdgeInsets!

    var emptyViewPaddings: UIEdgeInsets {
        invokedEmptyViewPaddingsGetter = true
        invokedEmptyViewPaddingsGetterCount += 1
        return stubbedEmptyViewPaddings
    }

    var invokedPrepareUI = false
    var invokedPrepareUICount = 0

    func prepareUI() {
        invokedPrepareUI = true
        invokedPrepareUICount += 1
    }

    var invokedShowEmptyView = false
    var invokedShowEmptyViewCount = 0

    func showEmptyView() {
        invokedShowEmptyView = true
        invokedShowEmptyViewCount += 1
    }

    var invokedHideEmptyView = false
    var invokedHideEmptyViewCount = 0

    func hideEmptyView() {
        invokedHideEmptyView = true
        invokedHideEmptyViewCount += 1
    }
}
