//
//  APIResponse.swift
//  NetworkManagerKit
//
//  Created by Yasin Akbas on 10.08.2022.
//  Copyright © 2022 com.yasinkbas. All rights reserved.
//

import Foundation

public struct PagedAPIResponse<Result: Decodable>: Decodable {
    public let page: Int
    public let results: Result
}
