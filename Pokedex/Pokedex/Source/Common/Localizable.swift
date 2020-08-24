//
//  LocalizableString.swift
//  Pokedex
//
//  Created by Martin Essuman on 24/08/2020.
//  Copyright © 2020 Martino Godswill Essuman. All rights reserved.
//

import Foundation

/// A class that could be language-wise localized should conform to this protocol.
public protocol Localizable {
    
    /// The name of the .string file containing the localized strings. The default implementation will use the conforming class's name.
    var tableName: String { get }
    
    /// The localized version of this string.
    var localized: String { get }
}

public extension Localizable where Self: RawRepresentable, Self.RawValue == String {
    
    /// String to be written when the localizable key cannot be found.
    private var fallbackValue: String {
        return "<localizable_key_not_found>"
    }
    
    var tableName: String {
        return String(describing: type(of: self))
    }
    
    var localized: String {
        return NSLocalizedString(rawValue, tableName: tableName, bundle: Bundle.main, value: fallbackValue, comment: "")
    }
    
    func localized(with arguments: [CVarArg]) -> String {
        String(format: localized, arguments: arguments)
    }
    
}
