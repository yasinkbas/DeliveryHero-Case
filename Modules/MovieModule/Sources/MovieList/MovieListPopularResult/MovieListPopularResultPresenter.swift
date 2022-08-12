//
//  MovieListPopularResultPresenter.swift
//  MovieModule
//
//  Created by Yasin Akbas on 12.08.2022.
//  Copyright © 2022 com.yasinkbas. All rights reserved.
//

import Foundation
import CommonKit
import NetworkManagerKit

protocol MovieListPopularResultPresenterInterface: AnyObject {
    var sizeOfCell: (width: Double, height: Double) { get }
    var minimumInteritemSpacingForSectionAt: Double { get }
    var numberOfItemsInSection: Int { get }
    
    func viewDidLoad()
    func willDisplayCell(indexPath: IndexPath)
}

protocol MovieListPopularResultPresenterDelegate: AnyObject {
    func movieListPopularResultFetchPopularMovies(page: Int)
}

protocol MovieListPopularResultModule: AnyObject {
    func addNewMovies(response: PagedAPIResponse<[Movie]>)
}

private extension MovieListPopularResultPresenter {
    enum Constants {
        static let heightOfCell: Double = 300
        static let minimumInteritemSpacingForSectionAt: Double = 20
    }
}

struct MovieListPopularResultPresenterArguments {
    weak var delegate: MovieListPopularResultPresenterDelegate?
    let response: PagedAPIResponse<[Movie]>
}

class MovieListPopularResultPresenter {
    private weak var view: MovieListPopularResultViewInterface?
    private let router: MovieListPopularResultRouterInterface
    private let arguments: MovieListPopularResultPresenterArguments
    private let screenWidth: Double
    private var movies: [Movie] = []
    private var page: Int = .zero
    private var totalPages: Int = .zero

    init(
        view: MovieListPopularResultViewInterface,
        router: MovieListPopularResultRouterInterface,
        arguments: MovieListPopularResultPresenterArguments,
        screenWidth: Double = Device.screenWidth
    ) {
        self.view = view
        self.router = router
        self.arguments = arguments
        self.screenWidth = screenWidth
        addNewMovies(response: arguments.response)
    }
}

// MARK: - MovieListPopularResultPresenterInterface
extension MovieListPopularResultPresenter: MovieListPopularResultPresenterInterface {    
    var sizeOfCell: (width: Double, height: Double) {
        (width: screenWidth / 2 - 20, height: Constants.heightOfCell)
    }
    
    var minimumInteritemSpacingForSectionAt: Double {
        Constants.minimumInteritemSpacingForSectionAt
    }
    
    var numberOfItemsInSection: Int {
        movies.count
    }
    
    func viewDidLoad() {
        view?.prepareUI()
    }
    
    func willDisplayCell(indexPath: IndexPath) {
        if totalPages > page && indexPath.item == movies.count - 2 {
            page += 1
            arguments.delegate?.movieListPopularResultFetchPopularMovies(page: page)
        }
    }
}

// MARK: - MovieListPopularResultModule
extension MovieListPopularResultPresenter: MovieListPopularResultModule {
    func addNewMovies(response: PagedAPIResponse<[Movie]>) {
        page = response.page
        totalPages = response.totalPages
        movies.append(contentsOf: response.results)
        view?.reloadData()
    }
}
