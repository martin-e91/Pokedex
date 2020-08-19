//
//  BaseCoordinator.swift
//  Pokedex
//
//  Created by Martin Essuman on 19/08/2020.
//  Copyright © 2020 Martino Godswill Essuman. All rights reserved.
//

import UIKit

/// A concrete base implementation for a Coordinator.
open class BaseCoordinator: Coordinator {
    
    public private(set) var navigationController: UINavigationController?
    
    public init(with navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    /// Starts this coordinator's flow. Must be overridden.
    open func start() {
        fatalError("Not Implemented")
    }
}
