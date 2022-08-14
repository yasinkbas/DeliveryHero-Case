//
//  MovieListPopularResultPresenter.swift
//  MovieModule
//
//  Created by Yasin Akbas on 12.08.2022.
//  Copyright © 2022 com.yasinkbas. All rights reserved.
//

import Foundation
import CommonKit
import CommonViewsKit
import NetworkManagerKit

protocol MovieListPopularResultPresenterInterface: AnyObject {
    var sizeOfCell: (width: Double, height: Double) { get }
    var minimumInteritemSpacingForSectionAt: Double { get }
    var numberOfItemsInSection: Int { get }
    
    func viewDidLoad()
    func willDisplayCell(indexPath: IndexPath)
    func movieCellPresenterArguments(for indexPath: IndexPath) -> CoverPosterCardCellPresenterArguments
}

protocol MovieListPopularResultPresenterDelegate: AnyObject {
    func movieListPopularResultFetchPopularMovies(page: Int)
}

protocol MovieListPopularResultModule: AnyObject {
    func addNewMovies(response: MovieListAPIResponse)
}

private extension MovieListPopularResultPresenter {
    enum Constants {
        static let heightOfCell: Double = 300
        static let minimumInteritemSpacingForSectionAt: Double = 20
    }
}

struct MovieListPopularResultPresenterArguments {
    weak var delegate: MovieListPopularResultPresenterDelegate?
}

final class MovieListPopularResultPresenter {
    private weak var view: MovieListPopularResultViewInterface?
    private let router: MovieListPopularResultRouterInterface
    private let arguments: MovieListPopularResultPresenterArguments
    private let screenWidth: Double
    private var movies: [MovieResponse] = []
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
    }
}

// MARK: - MovieListPopularResultPresenterInterface
extension MovieListPopularResultPresenter: MovieListPopularResultPresenterInterface {    
    var sizeOfCell: (width: Double, height: Double) {
        let cellWidth = screenWidth / 2 - 20
        return (width: cellWidth, height: cellWidth * 1.5 + 50)
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
        if totalPages > page && indexPath.item == movies.count - 4 {
            page += 1
            arguments.delegate?.movieListPopularResultFetchPopularMovies(page: page)
        }
    }
    
    func movieCellPresenterArguments(for indexPath: IndexPath) -> CoverPosterCardCellPresenterArguments {
        let movie = movies[indexPath.item]
        return .init(title: movie.title ?? "", secondaryTitle: movie.releaseDate ?? "", imageUrl: movie.backdropUrl)
    }
}

// MARK: - MovieListPopularResultModule
extension MovieListPopularResultPresenter: MovieListPopularResultModule {
    func addNewMovies(response: MovieListAPIResponse) {
        page = response.page
        totalPages = response.totalPages
        movies.append(contentsOf: response.results)
        view?.reloadData()
    }
}
