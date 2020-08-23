//
//  AppCoordinator.swift
//  Pokedex
//
//  Created by Martin Essuman on 19/08/2020.
//  Copyright © 2020 Martino Godswill Essuman. All rights reserved.
//

import UIKit

final class AppCoordinator: BaseCoordinator {
    private let injector: Injector
    
    required init(with navigationController: UINavigationController, injector: Injector) {
        self.injector = injector
        super.init(with: navigationController)
        navigationController.navigationBar.isTranslucent = false
    }
    
    override func start() {
        let presenter = PokemonListPresenter(with: self)
        let view = PokemonListViewController(with: presenter)
        presenter.view = view
        show(view, with: .pushFirst(animated: false))
    }
    
}

extension AppCoordinator: Navigator {
    
    enum Destinations {
        case pokemonList
    }
    
    func navigate(to destination: AppCoordinator.Destinations) {
        
    }
    
}
