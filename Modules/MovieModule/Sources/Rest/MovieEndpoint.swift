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
class MovieEndpoint {
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
}
