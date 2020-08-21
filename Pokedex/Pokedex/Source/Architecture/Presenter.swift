//
//  Presenter.swift
//  Pokedex
//
//  Created by Martin Essuman on 19/08/2020.
//  Copyright © 2020 Martino Godswill Essuman. All rights reserved.
//

import UIKit

/// Responsible for manipulating and providing data to the UI.
public protocol Presenter {
    associatedtype View
    associatedtype Nav: Navigator
    
    /// The view controlled binded to this presenter.
    var view: View! { get set }
    
    /// This coordinator associated with this presenter, handling the navigation flow from this node.
    var coordinator: Nav { get }
    
    init(with coordinator: Nav)
}
