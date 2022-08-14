//
//  MovieEndpoint.swift
//  MovieModule
//
//  Created by Yasin Akbas on 12.08.2022.
//  Copyright © 2022 com.yasinkbas. All rights reserved.
//

import Foundation
import CommonKit
import NetworkManagerKit
import NLab

typealias MovieListAPIResponse = PagedAPIResponse<[MovieResponse]>
typealias MovieSearchResultAPIResponse = PagedAPIResponse<[MovieResponse]>
typealias PeopleSearchResultAPIResponse = PagedAPIResponse<[PersonResponse]>
typealias GenreMoviesSearchResultAPIResponse = PagedAPIResponse<[MovieResponse]>

final class MovieEndpoint {
    let client = NetworkClientHandler.client(for: .themoviedb)
    
    init() { }
    
    func popular(page: String) -> NLTaskDirector<MovieListAPIResponse, Empty> {
        NLTaskPoint(client: client)
            .path("movie/popular")
            .method(.get)
            .injectMovieDBApiKey()
            .addParameter(.init(name: "page", value: page))
            .build().and.direct()
    }
    
    func genreList() -> NLTaskDirector<GenresResponse, Empty> {
        NLTaskPoint(client: client)
            .path("genre/movie/list")
            .method(.get)
            .injectMovieDBApiKey()
            .build().and.direct()
    }
    
    func searchMovie(page: String, query: String, includeAdult: Bool) -> NLTaskDirector<MovieSearchResultAPIResponse, Empty> {
        NLTaskPoint(client: client)
            .path("search/movie")
            .method(.get)
            .injectMovieDBApiKey()
            .addParameter(.init(name: "page", value: page))
            .addParameter(.init(name: "query", value: query))
            .addParameter(.init(name: "include_adult", value: includeAdult.toString))
            .build().and.direct()
    }
    
    func searchPeople(page: String, query: String, includeAdult: Bool) -> NLTaskDirector<PeopleSearchResultAPIResponse, Empty> {
        NLTaskPoint(client: client)
            .path("search/person")
            .method(.get)
            .injectMovieDBApiKey()
            .addParameter(.init(name: "page", value: page))
            .addParameter(.init(name: "query", value: query))
            .addParameter(.init(name: "include_adult", value: includeAdult.toString))
            .build().and.direct()
    }
    
    func searchGenreMovies(page: String, genreId: String) -> NLTaskDirector<GenreMoviesSearchResultAPIResponse, Empty> {
        NLTaskPoint(client: client)
            .path("discover/movie")
            .method(.get)
            .injectMovieDBApiKey()
            .addParameter(.init(name: "page", value: page))
            .addParameter(.init(name: "with_genres", value: genreId))
            .build().and.direct()
    }
}
