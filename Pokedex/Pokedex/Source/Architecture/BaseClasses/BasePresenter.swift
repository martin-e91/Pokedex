//
//  BasePresenter.swift
//  Pokedex
//
//  Created by Martin Essuman on 19/08/2020.
//  Copyright © 2020 Martino Godswill Essuman. All rights reserved.
//

import Foundation

/// A concrete base implementation for a Presenter.
open class BasePresenter<V, Nav>: Presenter where V: View, Nav: Navigator {
    public weak var view: V!
    
    public var coordinator: Nav
    
    required public init(with coordinator: Nav) {
        self.coordinator = coordinator
    }
    
}
