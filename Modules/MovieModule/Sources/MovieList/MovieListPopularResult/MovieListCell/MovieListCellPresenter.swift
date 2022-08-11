//
//  MovieListCellPresenter.swift
//  MovieModule
//
//  Created by Yasin Akbas on 11.08.2022.
//  Copyright © 2022 com.yasinkbas. All rights reserved.
//

import Foundation

protocol MovieListCellPresenterInterface: AnyObject {
    func load()
}

class MovieListCellPresenter {
    private weak var view: MovieListCellViewInterface?

    init(view: MovieListCellViewInterface) {
        self.view = view
    }
}

// MARK: - MovieListCellPresenterInterface
extension MovieListCellPresenter: MovieListCellPresenterInterface {
    func load() {
        view?.prepareUI()
    }
}
