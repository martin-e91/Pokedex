//
//  ReuseIdentifiable.swift
//  Pokedex
//
//  Created by Martin Essuman on 19/08/2020.
//  Copyright © 2020 Martino Godswill Essuman. All rights reserved.
//

import UIKit

/// A conforming class's reuseIdentifier will be defaulted to its class name.
public protocol ReuseIdentifiable: UIView {
    static var reuseIdentifier: String { get }
}

extension UIView: ReuseIdentifiable {
    /// Default identifier for this class. By default it's the class's literal name.
    public static var reuseIdentifier: String {
        return String(describing: self)
    }
}
