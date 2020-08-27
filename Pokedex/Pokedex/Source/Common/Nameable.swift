//
//  Nameable.swift
//  Pokedex
//
//  Created by Martin Essuman on 27/08/2020.
//  Copyright © 2020 Martino Godswill Essuman. All rights reserved.
//

import Foundation

/// An entity with a name.
protocol Nameable {
    
    /// The string name for this instance.
    var name: String { get }
}
