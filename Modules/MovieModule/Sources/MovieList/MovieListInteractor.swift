//
//  MovieListInteractor.swift
//  MovieModule
//
//  Created by Yasin Akbas on 11.08.2022.
//  Copyright © 2022 com.yasinkbas. All rights reserved.
//

import Foundation
import NetworkManagerKit

protocol MovieListInteractorInterface: AnyObject {
    func fetchPopularMovies()
}

protocol MovieListInteractorOutput: AnyObject {
    
}

final class MovieListInteractor {
    weak var output: MovieListInteractorOutput?
}

// MARK: - MovieListInteractorInterface
extension MovieListInteractor: MovieListInteractorInterface { 
    func fetchPopularMovies() {
        MovieAPI().popular().onData { response in
            response.results.forEach {
                print("--> \($0.title)")
            }
        }.onError { error in
            print("--> error \(error.localizedDescription)")
        }
        .onResponse { response in
            print("--> response \(response)")
        }
        .start()
    }
}
