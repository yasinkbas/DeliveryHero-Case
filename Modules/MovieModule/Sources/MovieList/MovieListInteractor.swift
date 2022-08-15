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
    func fetchMovieGenres()
    func searchMovies(page: Int, query: String)
    func searchPeople(page: Int, query: String)
    func searchGenreMovies(page: Int, genreId: Int)
}

protocol MovieListInteractorOutput: AnyObject {
    func handleFetchPopularMoviesResponse(response: MovieListAPIResponse)
    func handleFetchGenreListResponse(response: GenresResponse)
    func handleSearchMoviesResponse(response: MovieSearchResultAPIResponse)
    func handleSearchPeopleResponse(response: PeopleSearchResultAPIResponse)
    func handleSearchGenreMoviesResponse(response: GenreMoviesSearchResultAPIResponse)
    
    func handleRequestError(error: Error)
}

final class MovieListInteractor {
    weak var output: MovieListInteractorOutput?
}

// MARK: - MovieListInteractorInterface
extension MovieListInteractor: MovieListInteractorInterface { 
    func fetchPopularMovies(page: Int) {
        guard let output = output else { return }
        MovieEndpoint()
            .popular(page: page.toString)
            .onData(output.handleFetchPopularMoviesResponse(response:))
            .onError(output.handleRequestError(error:))
            .start()
    }
    
    func fetchMovieGenres() {
        guard let output = output else { return }
        MovieEndpoint()
            .genreList()
            .onData(output.handleFetchGenreListResponse(response:))
            .onError(output.handleRequestError(error:))
            .start()
    }
    
    func searchMovies(page: Int, query: String) {
        guard let output = output else { return }
        MovieEndpoint()
            .searchMovie(page: page.toString, query: query, includeAdult: false)
            .onData(output.handleSearchMoviesResponse(response:))
            .onError(output.handleRequestError(error:))
            .start()
    }
    
    func searchPeople(page: Int, query: String) {
        guard let output = output else { return }
        MovieEndpoint()
            .searchPeople(page: page.toString, query: query, includeAdult: false)
            .onData(output.handleSearchPeopleResponse(response:))
            .onError(output.handleRequestError(error:))
            .start()
    }
    
    func searchGenreMovies(page: Int, genreId: Int) {
        guard let output = output else { return }
        MovieEndpoint()
            .searchGenreMovies(page: page.toString, genreId: genreId.toString)
            .onData(output.handleSearchGenreMoviesResponse(response:))
            .onError(output.handleRequestError(error:))
            .start()
    }
}
