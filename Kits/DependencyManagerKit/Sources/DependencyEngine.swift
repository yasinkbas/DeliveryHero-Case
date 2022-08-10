//
//  DependencyEngine.swift
//  DependencyManagerKit
//
//  Created by Yasin Akbas on 10.08.2022.
//  Copyright © 2022 com.yasinkbas.DependencyManagerKit. All rights reserved.
//

import Foundation

public final class DependencyEngine {
    var dependencies: [ObjectIdentifier: () -> Any] = [:]
    public static let shared = DependencyEngine()
    
    private init() {}
    
    public func register(value: @autoclosure @escaping () -> Any, for interface: Any.Type) {
        dependencies[ObjectIdentifier(interface)] = value
    }
    
    public func read<Value>(for interface: Any.Type) -> Value {
        guard let value = dependencies[ObjectIdentifier(interface)]?() as? Value else {
            fatalError("\(interface) not found")
        }
        return value
    }
}
