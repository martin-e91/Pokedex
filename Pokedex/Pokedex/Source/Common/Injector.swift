//
//  Injector.swift
//  Pokedex
//
//  Created by Martin Essuman on 23/08/2020.
//  Copyright © 2020 Martino Godswill Essuman. All rights reserved.
//

import Foundation

/// A dependency manager.
public protocol Injector {
    
    /// Registers a new instance of an object by its type.
    ///
    /// - Parameters:
    ///   - type: Object's type.
    ///   - instance: The concrete instance of the registering object.
    func register<T>(type: T.Type, instance: T)
    
    /// Registers a new instance of an object by the given key.
    ///
    /// - Parameters:
    ///   - key: A string value associated with the object's instance.
    ///   - instance: The object's concrete instance.
    func register<T>(key: String, instance: T)
    
    /// Retrieves the instance of a previously registered object, if present.
    func resolve<T>() throws -> T
    
    /// Retrieves the instance of an object previously registered with the given key, if present.
    func resolve<T>(key: String) throws -> T
    
}

public enum InjectorError: Error {
    case invalidType
}
