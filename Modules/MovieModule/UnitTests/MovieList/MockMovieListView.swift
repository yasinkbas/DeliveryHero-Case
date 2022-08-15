//
//  MockMovieListView.swift
//  MovieModuleTests
//
//  Created by Yasin Akbas on 15.08.2022.
//  Copyright © 2022 com.yasinkbas. All rights reserved.
//

@testable import MovieModule
import CommonViewsKit
import UIKit

final class MockMovieListView: MovieListViewInterface {

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

    var invokedPrepareHeaderView = false
    var invokedPrepareHeaderViewCount = 0
    var invokedPrepareHeaderViewParameters: (height: Double, Void)?
    var invokedPrepareHeaderViewParametersList = [(height: Double, Void)]()

    func prepareHeaderView(height: Double) {
        invokedPrepareHeaderView = true
        invokedPrepareHeaderViewCount += 1
        invokedPrepareHeaderViewParameters = (height, ())
        invokedPrepareHeaderViewParametersList.append((height, ()))
    }

    var invokedPrepareMovieListPopularResult = false
    var invokedPrepareMovieListPopularResultCount = 0
    var invokedPrepareMovieListPopularResultParameters: (arguments: MovieListPopularResultPresenterArguments, Void)?
    var invokedPrepareMovieListPopularResultParametersList = [(arguments: MovieListPopularResultPresenterArguments, Void)]()
    var stubbedPrepareMovieListPopularResultResult: MovieListPopularResultModule!

    func prepareMovieListPopularResult(with arguments: MovieListPopularResultPresenterArguments) -> MovieListPopularResultModule {
        invokedPrepareMovieListPopularResult = true
        invokedPrepareMovieListPopularResultCount += 1
        invokedPrepareMovieListPopularResultParameters = (arguments, ())
        invokedPrepareMovieListPopularResultParametersList.append((arguments, ()))
        return stubbedPrepareMovieListPopularResultResult
    }

    var invokedPrepareMovieListSearchResult = false
    var invokedPrepareMovieListSearchResultCount = 0
    var invokedPrepareMovieListSearchResultParameters: (arguments: MovieListSearchResultPresenterArguments, Void)?
    var invokedPrepareMovieListSearchResultParametersList = [(arguments: MovieListSearchResultPresenterArguments, Void)]()
    var stubbedPrepareMovieListSearchResultResult: MovieListSearchResultModule!

    func prepareMovieListSearchResult(with arguments: MovieListSearchResultPresenterArguments) -> MovieListSearchResultModule {
        invokedPrepareMovieListSearchResult = true
        invokedPrepareMovieListSearchResultCount += 1
        invokedPrepareMovieListSearchResultParameters = (arguments, ())
        invokedPrepareMovieListSearchResultParametersList.append((arguments, ()))
        return stubbedPrepareMovieListSearchResultResult
    }

    var invokedHideMovieListSearchResult = false
    var invokedHideMovieListSearchResultCount = 0

    func hideMovieListSearchResult() {
        invokedHideMovieListSearchResult = true
        invokedHideMovieListSearchResultCount += 1
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

    var invokedShowLoading = false
    var invokedShowLoadingCount = 0

    func showLoading() {
        invokedShowLoading = true
        invokedShowLoadingCount += 1
    }

    var invokedHideLoading = false
    var invokedHideLoadingCount = 0

    func hideLoading() {
        invokedHideLoading = true
        invokedHideLoadingCount += 1
    }

    var invokedShowAlert = false
    var invokedShowAlertCount = 0
    var invokedShowAlertParameters: (message: String, Void)?
    var invokedShowAlertParametersList = [(message: String, Void)]()

    func showAlert(message: String) {
        invokedShowAlert = true
        invokedShowAlertCount += 1
        invokedShowAlertParameters = (message, ())
        invokedShowAlertParametersList.append((message, ()))
    }
}
