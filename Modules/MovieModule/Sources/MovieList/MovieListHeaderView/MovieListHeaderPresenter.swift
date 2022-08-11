//
//  MovieListHeaderPresenter.swift
//  MovieModule
//
//  Created by Yasin Akbas on 11.08.2022.
//  Copyright © 2022 com.yasinkbas. All rights reserved.
//

import Foundation

protocol MovieListHeaderPresenterInterface: AnyObject {
    func load()
    func doneIconTapped()
    func searchContainerViewTapped()
    func searchTextFieldDidChange(_ text: String?)
}

protocol MovieListHeaderPresenterDelegate: AnyObject {
    func searchButtonTapped(searchText: String)
}

class MovieListHeaderPresenter {
    private weak var view: MovieListHeaderViewInterface?
    private weak var delegate: MovieListHeaderPresenterDelegate?
    
    private var searchText: String?
    private var searchIconIsExpanded: Bool = false

    init(view: MovieListHeaderViewInterface, delegate: MovieListHeaderPresenterDelegate) {
        self.view = view
        self.delegate = delegate
    }
}

// MARK: - MovieListHeaderPresenterInterface
extension MovieListHeaderPresenter: MovieListHeaderPresenterInterface {
    func load() {
        view?.prepareUI()
    }
    
    func doneIconTapped() {
        searchContainerViewTapped()
        delegate?.searchButtonTapped(searchText: searchText ?? .empty)
    }
    
    func searchContainerViewTapped() {
        if searchIconIsExpanded {
            view?.hideSearchTextField()
            view?.setTextField(text: .empty)
        } else {
            view?.showSearchTextField()
        }
        searchIconIsExpanded.toggle()
    }
    
    func searchTextFieldDidChange(_ text: String?) {
        searchText = text
    }
}
