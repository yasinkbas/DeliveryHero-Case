//
//  PersonResponse.swift
//  MovieModule
//
//  Created by Yasin Akbas on 14.08.2022.
//  Copyright © 2022 com.yasinkbas. All rights reserved.
//

import Foundation
import CommonViewsKit

struct PersonResponse: Decodable {
    let id: Int
    let name: String
    let popularity: Double
    let profilePath: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case popularity
        case profilePath = "profile_path"
    }
    
    var profilePicture: String? {
        guard let profilePath = profilePath else { return nil }
        return "https://image.tmdb.org/t/p/w500\(profilePath)"
    }
}

extension PersonResponse: CoverPosterCardShowableModel {
    var coverPosterTitle: String { name }
    var coverPosterSubtitle: String? { "Popularity: \(popularity)" }
    var coverPosterImagePath: String { profilePicture ?? "" }
}
