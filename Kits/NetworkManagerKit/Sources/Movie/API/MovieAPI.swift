//
//  MovieAPI.swift
//  NetworkManagerKit
//
//  Created by Yasin Akbas on 10.08.2022.
//  Copyright © 2022 com.yasinkbas. All rights reserved.
//

import Foundation
import NLab

public class MovieAPI {
    let client = NetworkClientHandler.client(for: .themoviedb)
    
    public init() { }
    
    public func popular(page: String = "1") -> NLTaskDirector<PagedAPIResponse<[Movie]>, Empty> {
        NLTaskPoint(client: client)
            .path("movie/popular")
            .method(.get)
            .injectMovieDBApiKey()
            .addParameter(.init(name: "page", value: page))
            .build().and.direct()
    }
}
