//
//  DummyCoverPosterCardShowableModel.swift
//  MovieModuleTests
//
//  Created by Yasin Akbas on 15.08.2022.
//  Copyright © 2022 com.yasinkbas. All rights reserved.
//

@testable import MovieModule
import CommonViewsKit

final class DummyCoverPosterCardShowableModel: CoverPosterCardShowableModel {
    var coverPosterId: Int?
    var coverPosterTitle: String
    var coverPosterSubtitle: String?
    var coverPosterImagePath: String
    

    init(coverPosterId: Int? = nil, coverPosterTitle: String, coverPosterSubtitle: String? = nil, coverPosterImagePath: String) {
        self.coverPosterId = coverPosterId
        self.coverPosterTitle = coverPosterTitle
        self.coverPosterSubtitle = coverPosterSubtitle
        self.coverPosterImagePath = coverPosterImagePath
    }
}
