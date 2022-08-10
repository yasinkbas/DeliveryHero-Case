//
//  NetworkConfigs.swift
//  NetworkManagerKit
//
//  Created by Yasin Akbas on 10.08.2022.
//  Copyright © 2022 com.yasinkbas. All rights reserved.
//

import Foundation

public class NetworkConfigs {
    static var themoviedbApiKey: String = "93f653399c6d77b90da1f3a2b87fb4a2"
    
    public static func register(themoviedbApiKey: String) {
        Self.themoviedbApiKey = themoviedbApiKey
    }
}
