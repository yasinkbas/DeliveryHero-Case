//
//  NetworkConfigs.swift
//  NetworkManagerKit
//
//  Created by Yasin Akbas on 10.08.2022.
//  Copyright © 2022 com.yasinkbas. All rights reserved.
//

import Foundation

public class NetworkConfigs {
    static var themoviedbApiKey: String = ""
    
    public static func register(themoviedbApiKey: String) {
        Self.themoviedbApiKey = themoviedbApiKey
    }
}
