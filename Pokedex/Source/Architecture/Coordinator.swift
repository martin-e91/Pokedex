//
//  Coordinator.swift
//  Pokedex
//
//  Created by Martin Essuman on 19/08/2020.
//  Copyright © 2020 Martino Godswill Essuman. All rights reserved.
//

import UIKit

/// An entity responsible for handling navigation between nodes.
public protocol Coordinator: AnyObject {
    
    /// The root navigation controller for this coordinator's node.
    var navigationController: UINavigationController? { get }
    
    /// Starts this coordinator's flow.
    func start()
}
