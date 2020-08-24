//
//  Cache.swift
//  Pokedex
//
//  Created by Martin Essuman on 23/08/2020.
//  Copyright © 2020 Martino Godswill Essuman. All rights reserved.
//

import Foundation

/// An NSCache wrapper for storing structs.
final class Cache<Key: Hashable, Value> {
    private let wrapped = NSCache<WrappedKey, Entry>()
    
    /// Sets the value of the specified key in the cache.
    /// - Parameters:
    ///   - value: The object to be stored in the cache.
    ///   - key: The key with which to associate the value.
    func insert(_ value: Value, forKey key: Key) {
        let entry = Entry(value: value)
        wrapped.setObject(entry, forKey: WrappedKey(key))
    }
    
    /// Returns the value associated with a given key.
    /// - Parameter key: An object identifying the value.
    /// - Returns: The value associated with key, or nil if no value is associated with key.
    func value(forKey key: Key) -> Value? {
        let entry = wrapped.object(forKey: WrappedKey(key))
        return entry?.value
    }
    
    /// Removes the value of the specified key in the cache.
    /// - Parameter key: The key identifying the value to be removed.
    func removeValue(forKey key: Key) {
        wrapped.removeObject(forKey: WrappedKey(key))
    }
}

private extension Cache {
    
    /// A key  for uniquely identify an object inside the cache.
    final class WrappedKey: NSObject {
        let key: Key
        
        override var hash: Int { return key.hashValue }

        init(_ key: Key) { self.key = key }

        override func isEqual(_ object: Any?) -> Bool {
            guard let value = object as? WrappedKey else {
                return false
            }
            return value.key == key
        }
    }
    
    /// An entry for this Cache type.
    final class Entry {
        let value: Value

        init(value: Value) {
            self.value = value
        }
    }

}
