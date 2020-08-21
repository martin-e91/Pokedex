//
//  View.swift
//  Pokedex
//
//  Created by Martin Essuman on 19/08/2020.
//  Copyright © 2020 Martino Godswill Essuman. All rights reserved.
//

import UIKit

public protocol View: UIViewController {
    associatedtype ConcretePresenter
    
    var presenter: ConcretePresenter { get }
    
    init(with presenter: ConcretePresenter)
    
    func updateState()
}
