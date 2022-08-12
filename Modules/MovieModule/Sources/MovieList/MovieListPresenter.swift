//
//  MovieListPresenter.swift
//  MovieModule
//
//  Created by Yasin Akbas on 11.08.2022.
//  Copyright © 2022 com.yasinkbas. All rights reserved.
//

import Foundation
import CommonKit
import NetworkManagerKit

protocol MovieListPresenterInterface: AnyObject {
    var movieListHeaderPresenterDelegate: MovieListHeaderPresenterDelegate { get }
    
    func viewDidLoad()
}

private extension MovieListPresenter {
    enum Constants {
        static let headerViewHeightSmallDevices: Double = 70
        static let headerViewHeightBigDevices: Double = 120
        
        static let popularMoviesFetchInitialPageNumber: Int = 1
    }
}

private extension MovieListPresenter {
    enum State {
        case empty, list, search, loading
    }
}

final class MovieListPresenter {
    private weak var view: MovieListViewInterface?
    private let router: MovieListRouterInterface
    private let interactor: MovieListInteractorInterface
    private let isIphoneXOrBigger: Bool
    
    private var movieListPopularResultModule: MovieListPopularResultModule?
    
    private var state: State = .empty {
        didSet {
            updateUI()
        }
    }
    
    init(
        view: MovieListViewInterface,
        router: MovieListRouterInterface,
        interactor: MovieListInteractorInterface,
        isIphoneXOrBigger: Bool = Device.isIphoneXOrBigger
    ) {
        self.view = view
        self.router = router
        self.interactor = interactor
        self.isIphoneXOrBigger = isIphoneXOrBigger
    }
    
    func updateUI() {
        switch state {
        case .empty:
            view?.hideLoading()
            view?.showEmptyView()
        case .list:
            view?.hideLoading()
            view?.hideEmptyView()
        case .search:
            view?.hideLoading()
            view?.hideEmptyView()
        case .loading:
            view?.showLoading()
            view?.hideEmptyView()
        }
    }
    
    private func fetchPopularMovies(page: Int) {
        state = .loading
        interactor.fetchPopularMovies(page: 1)
    }
}

// MARK: - MovieListPresenterInterface
extension MovieListPresenter: MovieListPresenterInterface {
    var movieListHeaderPresenterDelegate: MovieListHeaderPresenterDelegate { self }
    
    func viewDidLoad() {
        view?.prepareUI()
        view?.prepareHeaderView(
            height: isIphoneXOrBigger
            ? Constants.headerViewHeightBigDevices
            : Constants.headerViewHeightSmallDevices
        )
        fetchPopularMovies(page: Constants.popularMoviesFetchInitialPageNumber)
    }
}

// MARK: - MovieListInteractorOutput
extension MovieListPresenter: MovieListInteractorOutput { 
    func fetchPopularMoviesResponse(response: MovieListAPIResponse) {
        view?.hideLoading()
        guard !response.results.isEmpty else {
            state = .empty
            return
        }
        if movieListPopularResultModule == nil {
            movieListPopularResultModule = view?.showMovieListPopularResult(with: .init(delegate: self))
        }
        movieListPopularResultModule?.addNewMovies(response: response)
        state = .list
    }
    
    func handleRequestError(errorMessage: String) {
        view?.hideLoading()
        view?.showAlert(message: errorMessage)
        state = .empty
    }
}

// MARK: - MovieListHeaderPresenterDelegate
extension MovieListPresenter: MovieListHeaderPresenterDelegate {
    func searchButtonTapped(searchText: String) {
        // TODO: interactor.searchText()
    }
}

// MARK: - MovieListPopularResultPresenterDelegate
extension MovieListPresenter: MovieListPopularResultPresenterDelegate {
    func movieListPopularResultFetchPopularMovies(page: Int) {
        interactor.fetchPopularMovies(page: page)
    }
}
