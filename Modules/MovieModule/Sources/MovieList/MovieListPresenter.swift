//
//  MovieListPresenter.swift
//  MovieModule
//
//  Created by Yasin Akbas on 11.08.2022.
//  Copyright © 2022 com.yasinkbas. All rights reserved.
//

import Foundation

protocol MovieListPresenterInterface: AnyObject {
    func viewDidLoad()
}

class MovieListPresenter {
    private weak var view: MovieListViewInterface?
    private let router: MovieListRouterInterface
    private let interactor: MovieListInteractorInterface

    init(
        view: MovieListViewInterface,
        router: MovieListRouterInterface,
        interactor: MovieListInteractorInterface
    ) {
        self.view = view
        self.router = router
        self.interactor = interactor
    }
}

// MARK: - MovieListPresenterInterface
extension MovieListPresenter: MovieListPresenterInterface {
    func viewDidLoad() {
        view?.prepareUI()
        interactor.fetchPopularMovies()
        view?.showEmptyView()
    }
}

// MARK: - MovieListInteractorOutput
extension MovieListPresenter: MovieListInteractorOutput { 
    
}
