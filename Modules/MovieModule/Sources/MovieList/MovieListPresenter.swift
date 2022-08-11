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
    }
}

private extension MovieListPresenter {
    enum State {
        case empty, list, search
    }
}

class MovieListPresenter {
    private weak var view: MovieListViewInterface?
    private let router: MovieListRouterInterface
    private let interactor: MovieListInteractorInterface
    private let isIphoneXOrBigger: Bool
    
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
            view?.showEmptyView()
        case .list:
            view?.hideEmptyView()
        case .search:
            view?.hideEmptyView()
        }
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
        
        view?.showLoading()
        interactor.fetchPopularMovies(page: 1)
    }
}

// MARK: - MovieListInteractorOutput
extension MovieListPresenter: MovieListInteractorOutput { 
    func fetchPopularMoviesResponse(response: [Movie]) {
        view?.hideLoading()
        print("--> fetched movies count \(response.count)")
        view?.showMovieListPopularResult(with: .init(movies: response))
    }
    
    func handleRequestError(errorMessage: String) {
        // TODO: show alert
        
    }
}

// MARK: - MovieListHeaderPresenterDelegate
extension MovieListPresenter: MovieListHeaderPresenterDelegate {
    func searchButtonTapped(searchText: String) {
        // TODO: interactor.searchText()
    }
}
