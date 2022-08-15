//
//  PropertyListParser.swift
//  CommonKit
//
//  Created by Yasin Akbas on 11.08.2022.
//  Copyright © 2022 com.yasinkbas. All rights reserved.
//

import Foundation

public class PropertyListParser {
    enum PropertyListParserError: Error {
        case pathNotFound
        case decoderError
    }
    
    public static func read<T: Decodable>(fileName: String) throws -> T {
        guard let url = Bundle.main.url(forResource: fileName, withExtension: "plist") else {
            throw PropertyListParserError.pathNotFound
        }
        do {
            let data = try Data(contentsOf: url)
            let result = try PropertyListDecoder().decode(T.self, from: data)
            return result
        } catch {
            throw PropertyListParserError.decoderError
        }
    }
}
