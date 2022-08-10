//
//  NetworkClient.swift
//  NetworkManagerKit
//
//  Created by Yasin Akbas on 10.08.2022.
//  Copyright © 2022 com.yasinkbas. All rights reserved.
//

import Foundation
import NLab

final class NetworkClientHandler {
    enum ClientType {
        case themoviedb
        
        var baseUrl: URL {
            return URL(string: "https://api.themoviedb.org/3/")!
        }
    }
    
    static func client(for client: ClientType) -> NLClient {
        NLClient(baseURL: client.baseUrl)
    }
}

extension NLTaskPoint {
    func injectMovieDBApiKey() -> Self {
        addParameter(.init(name: "api_key", value: NetworkConfigs.themoviedbApiKey))
    }
}
