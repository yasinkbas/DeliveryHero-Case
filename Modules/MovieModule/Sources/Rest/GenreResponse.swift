//
//  GenreResponse.swift
//  MovieModule
//
//  Created by Yasin Akbas on 13.08.2022.
//  Copyright © 2022 com.yasinkbas. All rights reserved.
//

import Foundation

struct GenresResponse: Decodable {
    let genres: [GenresItem]
}

struct GenresItem: Decodable {
    let id: Int
    let name: String
}
