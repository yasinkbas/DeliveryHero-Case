//
//  MovieListSearchResultWidgetItem.swift
//  MovieModule
//
//  Created by Yasin Akbas on 13.08.2022.
//  Copyright © 2022 com.yasinkbas. All rights reserved.
//

import Foundation
import CommonViewsKit

struct MovieListSearchResultWidgetItem {
    enum WidgetType {
        case movie
        case people
        case genre
    }
    
    let title: String
    let height: Double
    let widgetType: WidgetType
    let result: [CoverPosterCardShowableModel]
}
