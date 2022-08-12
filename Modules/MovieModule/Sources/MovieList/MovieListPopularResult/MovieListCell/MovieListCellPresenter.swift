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

struct MovieListCellPresenterArguments {
    let movie: MovieResponse
}

final class MovieListCellPresenter {
    private weak var view: MovieListCellViewInterface?
    private let arguments: MovieListCellPresenterArguments

    init(view: MovieListCellViewInterface, arguments: MovieListCellPresenterArguments) {
        self.view = view
        self.arguments = arguments
    }
}

// MARK: - MovieListCellPresenterInterface
extension MovieListCellPresenter: MovieListCellPresenterInterface {
    func load() {
        view?.prepareUI()
        view?.setCoverImageView(path: arguments.movie.posterUrl)
        view?.setMovieTitleLabel(text: arguments.movie.title ?? "")
        view?.setMovieReleaseDateLabel(text: arguments.movie.releaseDate ?? "")
    }
}
