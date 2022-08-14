//
//  MovieResponse.swift
//  NetworkManagerKit
//
//  Created by Yasin Akbas on 10.08.2022.
//  Copyright © 2022 com.yasinkbas. All rights reserved.
//

import Foundation
import CommonViewsKit

struct MovieResponse: Decodable {
    let id: Int?
    let title: String?
    let overview: String?
    let popularity: Double?
    let video: Bool?
    let originalTitle: String?
    let releaseDate: String?
    let voteAverage: Double?
    let voteCount: Int?
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case overview
        case popularity
        case video
        case originalTitle = "original_title"
        case releaseDate = "release_date"
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
    }
    
    let posterPath: String?
    let backdropPath: String?
    
    var backdropUrl: String {
        return "https://image.tmdb.org/t/p/w500\(backdropPath ?? "")"
    }
    
    var posterUrl: String {
        return "https://image.tmdb.org/t/p/w500\(posterPath ?? "")"
    }
}

extension MovieResponse: CoverPosterCardShowableModel {
    var coverPosterId: Int? { id }
    var coverPosterTitle: String { title ?? "" }
    var coverPosterSubtitle: String? { releaseDate }
    var coverPosterImagePath: String { posterUrl }
}
