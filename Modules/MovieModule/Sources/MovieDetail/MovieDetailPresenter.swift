//
//  MovieDetailPresenter.swift
//  MovieModule
//
//  Created by Yasin Akbas on 15.08.2022.
//  Copyright © 2022 com.yasinkbas. All rights reserved.
//

import Foundation

protocol MovieDetailPresenterInterface: AnyObject {
    var emptyViewMessage: String { get }
    
    func viewDidLoad()
}

struct MovieDetailPresenterArguments {
    let id: Int
}

final class MovieDetailPresenter {
    private weak var view: MovieDetailViewInterface?
    private let router: MovieDetailRouterInterface
    private let interactor: MovieDetailInteractorInterface
    private let arguments: MovieDetailPresenterArguments

    init(
        view: MovieDetailViewInterface,
        router: MovieDetailRouterInterface,
        interactor: MovieDetailInteractorInterface,
        arguments: MovieDetailPresenterArguments
    ) {
        self.view = view
        self.router = router
        self.interactor = interactor
        self.arguments = arguments
    }
}

// MARK: - MovieDetailPresenterInterface
extension MovieDetailPresenter: MovieDetailPresenterInterface {
    var emptyViewMessage: String {
        "Test - ID(\(arguments.id) Movie Detail Page"
    }
    
    func viewDidLoad() {
        view?.prepareUI()
        view?.showEmptyView()
    }
}

// MARK: - MovieDetailInteractorOutput
extension MovieDetailPresenter: MovieDetailInteractorOutput { 
    
}
