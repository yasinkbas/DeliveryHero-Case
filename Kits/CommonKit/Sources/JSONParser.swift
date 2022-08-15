//
//  JSONParser.swift
//  CommonKit
//
//  Created by Yasin Akbas on 15.08.2022.
//  Copyright © 2022 com.yasinkbas. All rights reserved.
//

import Foundation

public class JSONParser {
    public static func decode<T: Decodable>(for model: T.Type, fileName: String, bundle: Bundle) -> T {
        let data = readFile(for: fileName, bundle: bundle)
        do {
            let decodedData = try JSONDecoder().decode(model, from: data)
            return decodedData
        } catch {
            fatalError()
        }
    }
    
    fileprivate static func readFile(for name: String, bundle: Bundle) -> Data {
        do {
            if let bundlePath = bundle.path(forResource: name, ofType: "json"),
               let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) {
                return jsonData
            }
        } catch {
            print(error.localizedDescription)
        }
        fatalError()
    }
}
