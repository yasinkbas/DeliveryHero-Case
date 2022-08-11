//
//  MovieListPresenter.swift
//  MovieModule
//
//  Created by Yasin Akbas on 11.08.2022.
//  Copyright © 2022 com.yasinkbas. All rights reserved.
//

import Foundation
import CommonKit

protocol MovieListPresenterInterface: AnyObject {
    var movieListHeaderPresenterDelegate: MovieListHeaderPresenterDelegate { get }
    
    func viewDidLoad()
}

extension MovieListPresenter {
    enum Constants {
        static let headerViewHeightSmallDevices: Double = 70
        static let headerViewHeightBigDevices: Double = 120
    }
}

class MovieListPresenter {
    private weak var view: MovieListViewInterface?
    private let router: MovieListRouterInterface
    private let interactor: MovieListInteractorInterface
    private let isIphoneXOrBigger: Bool
    
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
}

// MARK: - MovieListPresenterInterface
extension MovieListPresenter: MovieListPresenterInterface {
    var movieListHeaderPresenterDelegate: MovieListHeaderPresenterDelegate { self }
    
    func viewDidLoad() {
        view?.prepareUI()
        interactor.fetchPopularMovies()
        view?.prepareHeaderView(height: isIphoneXOrBigger
                                ? Constants.headerViewHeightBigDevices
                                : Constants.headerViewHeightSmallDevices)
        
        view?.showEmptyView()
    }
}

// MARK: - MovieListInteractorOutput
extension MovieListPresenter: MovieListInteractorOutput { 
    
}

// MARK: - MovieListHeaderPresenterDelegate
extension MovieListPresenter: MovieListHeaderPresenterDelegate {
    func searchButtonTapped(searchText: String) {
        // TODO: interactor.searchText()
    }
}
