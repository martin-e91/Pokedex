//
//  ProviderInjector.swift
//  Pokedex
//
//  Created by Martin Essuman on 23/08/2020.
//  Copyright © 2020 Martino Godswill Essuman. All rights reserved.
//

import Foundation

public final class ConcreteInjector {
    
    /// The set of instances of this container.
    var components = [String: Any]()
    
    public init() {}
}

extension ConcreteInjector: Injector {
    
    public func register<T>(type: T.Type, instance: T) {
        let key = "\(type)"
        components[key] = instance
    }
    
    public func register<T>(key: String, instance: T) {
        components[key] = instance
    }
    
    public func resolve<T>() throws -> T {
        let key = "\(T.self)"
        return try internalResolve(for: key)
    }
    
    public func resolve<T>(key: String) throws -> T {
        return try internalResolve(for: key)
    }
}

private extension ConcreteInjector {
    func internalResolve<T>(for key: String) throws -> T {
        guard let component = components[key] else {
            throw InjectorError.invalidType
        }
        
        guard let result = component as? T else {
            throw InjectorError.invalidType
        }
        return result
    }
}
