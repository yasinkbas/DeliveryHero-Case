//
//  MovieListInteractor.swift
//  MovieModule
//
//  Created by Yasin Akbas on 11.08.2022.
//  Copyright © 2022 com.yasinkbas. All rights reserved.
//

import Foundation
import CommonKit
import NetworkManagerKit

protocol MovieListInteractorInterface: AnyObject {
    func fetchPopularMovies(page: Int)
}

protocol MovieListInteractorOutput: AnyObject {
    func fetchPopularMoviesResponse(response: PagedAPIResponse<[Movie]>)
    func handleRequestError(errorMessage: String)
}

final class MovieListInteractor {
    weak var output: MovieListInteractorOutput?
}

// MARK: - MovieListInteractorInterface
extension MovieListInteractor: MovieListInteractorInterface { 
    func fetchPopularMovies(page: Int) {
        MovieEndpoint()
            .popular()
            .onData { [weak self] response in
                self?.output?.fetchPopularMoviesResponse(response: response)
            }.onError { [weak self] error in
                self?.output?.handleRequestError(errorMessage: error.localizedDescription)
            }
            .start()
    }
}
