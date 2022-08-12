//
//  MovieResponse.swift
//  NetworkManagerKit
//
//  Created by Yasin Akbas on 10.08.2022.
//  Copyright © 2022 com.yasinkbas. All rights reserved.
//

import Foundation

public struct MovieResponse: Decodable {
    public let id: Int?
    public let title: String?
    public let overview: String?
    public let popularity: Double?
    public let video: Bool?
    public let originalTitle: String?
    public let releaseDate: String?
    public let voteAverage: Double?
    public let voteCount: Int?
    
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
    
    public let posterPath: String?
    public let backdropPath: String?
    
    public var backdropUrl: String {
        return "https://image.tmdb.org/t/p/w500\(backdropPath ?? "")"
    }
    
    public var posterUrl: String {
        return "https://image.tmdb.org/t/p/w500\(posterPath ?? "")"
    }
}
