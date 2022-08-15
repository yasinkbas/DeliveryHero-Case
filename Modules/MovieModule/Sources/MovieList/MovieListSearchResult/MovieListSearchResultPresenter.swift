//
//  MovieListSearchResultPresenter.swift
//  MovieModule
//
//  Created by Yasin Akbas on 13.08.2022.
//  Copyright © 2022 com.yasinkbas. All rights reserved.
//

import Foundation
import CommonKit

protocol MovieListSearchResultPresenterInterface: AnyObject {
    var minimumInteritemSpacingForSectionAt: Double { get }
    var numberOfItemsInSection: Int { get }
    
    func viewDidLoad()
    func sizeOfCell(for indexPath: IndexPath) -> (width: Double, height: Double)
    func movieListSearchResultCellArguments(for indexPath: IndexPath) -> MovieListSearchResultCellPresenterArguments
}

protocol MovieListSearchResultPresenterDelegate: AnyObject {
    func movieListSearchResultSearchMovies(page: Int, query: String)
    func movieListSearchResultSearchGenreMovies(page: Int, query: String)
    func movieListSearchResultSearchPeople(page: Int, query: String)
}

protocol MovieListSearchResultModule { }

struct MovieListSearchResultPresenterArguments {
    weak var delegate: MovieListSearchResultPresenterDelegate?
    let widgets: [MovieListSearchResultWidgetItem]
}

private extension MovieListSearchResultPresenter {
    enum Constants {
        static let minimumInteritemSpacingForSectionAt: Double = 10
    }
}

final class MovieListSearchResultPresenter {
    private weak var view: MovieListSearchResultViewInterface?
    private let router: MovieListSearchResultRouterInterface
    private let arguments: MovieListSearchResultPresenterArguments
    private let screenWidth: Double

    init(
        view: MovieListSearchResultViewInterface,
        router: MovieListSearchResultRouterInterface,
        arguments: MovieListSearchResultPresenterArguments,
        screenWidth: Double = Device.screenWidth
    ) {
        self.view = view
        self.router = router
        self.arguments = arguments
        self.screenWidth = screenWidth
    }
}

// MARK: - MovieListSearchResultPresenterInterface
extension MovieListSearchResultPresenter: MovieListSearchResultPresenterInterface {
    var minimumInteritemSpacingForSectionAt: Double {
        Constants.minimumInteritemSpacingForSectionAt
    }
    
    var numberOfItemsInSection: Int {
        arguments.widgets.count
    }
    
    func viewDidLoad() {
        view?.prepareUI()
    }
    
    func sizeOfCell(for indexPath: IndexPath) -> (width: Double, height: Double) {
        let cellWidth = screenWidth
        return (width: cellWidth, height: arguments.widgets[indexPath.item].height)
    }
    
    func movieListSearchResultCellArguments(for indexPath: IndexPath) -> MovieListSearchResultCellPresenterArguments {
        MovieListSearchResultCellPresenterArguments(widget: arguments.widgets[indexPath.item], delegate: self)
    }
}

// MARK: - MovieListSearchResultModule
extension MovieListSearchResultPresenter: MovieListSearchResultModule {
}

// MARK: - MovieListSearchResultCellPresenterDelegate
extension MovieListSearchResultPresenter: MovieListSearchResultCellPresenterDelegate {
    func navigateToPersonDetail(with id: Int) {
        router.navigateToPersonDetail(with: id)
    }
    
    func navigateToMovieDetail(with id: Int) {
        router.navigateToMovieDetail(with: id)
    }
}
