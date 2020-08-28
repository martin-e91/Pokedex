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
    private let dateProvider: () -> Date
    private let entryLifetime: TimeInterval
    
    init(dateProvider: @escaping () -> Date = Date.init,
         entryLifetime: TimeInterval = 12 * 60 * 60) {
        self.dateProvider = dateProvider
        self.entryLifetime = entryLifetime
    }
    
    /// Sets the value of the specified key in the cache.
    /// - Parameters:
    ///   - value: The object to be stored in the cache.
    ///   - key: The key with which to associate the value.
    func insert(_ value: Value, forKey key: Key) {
        let date = dateProvider().addingTimeInterval(entryLifetime)
        let entry = Entry(value: value, expirationDate: date)
        wrapped.setObject(entry, forKey: WrappedKey(key))
    }
    
    /// Returns the value associated with a given key.
    /// - Parameter key: An object identifying the value.
    /// - Returns: The value associated with key, or nil if no value is associated with key.
    func value(forKey key: Key) -> Value? {
        return entry(forKey: key)?.value
    }
    
    /// Removes the value of the specified key in the cache.
    /// - Parameter key: The key identifying the value to be removed.
    func removeValue(forKey key: Key) {
        wrapped.removeObject(forKey: WrappedKey(key))
    }
    
    /// Empties the cache.
    func reset() {
        wrapped.removeAllObjects()
    }
}

// MARK: - Helpers

private extension Cache {
    
    /// Returns the cache entry for the given key, if any.
    /// - Parameter key: key that may be associated with a value stored in the cache.
    /// - Returns: the cache entry for the given key, if any.
    func entry(forKey key: Key) -> Entry? {
        guard let entry = wrapped.object(forKey: WrappedKey(key)) else {
            return nil
        }

        guard dateProvider() < entry.expirationDate else {
            removeValue(forKey: key)
            return nil
        }
        return entry
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
    
    /// A Cache entry.
    final class Entry {
        /// Value for this entry.
        let value: Value
        
        /// This entry's expiration date.
        let expirationDate: Date
        
        init(value: Value, expirationDate: Date) {
            self.value = value
            self.expirationDate = expirationDate
        }
        
    }

}
