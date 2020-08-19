//
//  Navigator.swift
//  Pokedex
//
//  Created by Martin Essuman on 19/08/2020.
//  Copyright © 2020 Martino Godswill Essuman. All rights reserved.
//

import Foundation

/// An entity responsible for navigation.
public protocol Navigator {
    associatedtype Destination
    
    /// Navigate to the specified destination.
    /// - Parameter destination: A destination reachable by this navigator.
    func navigate(to destination: Destination)
}
