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
}

private extension MovieListPopularResultPresenter {
    enum Constants {
        static let heightOfCell: Double = 300
        static let minimumInteritemSpacingForSectionAt: Double = 20
    }
}

struct MovieListPopularResultPresenterArguments {
    let movies: [Movie]
}

class MovieListPopularResultPresenter {
    private weak var view: MovieListPopularResultViewInterface?
    private let router: MovieListPopularResultRouterInterface
    private let arguments: MovieListPopularResultPresenterArguments
    private let screenWidth: Double
    private var movies: [Movie] = []

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
        movies.append(contentsOf: arguments.movies)
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
}
