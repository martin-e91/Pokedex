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
        let pokemonProvider: PokemonProvider
        
        do {
            pokemonProvider = try injector.resolve()
        } catch InjectorError.invalidType {
            fatalError("Couldn't retrieve pokemon provider instance")
        } catch let error {
            fatalError(error.localizedDescription)
        }
        
        let presenter = PokemonListPresenter(with: self, pokemonProvider: pokemonProvider)
        let view = PokemonListViewController(with: presenter)
        presenter.view = view
        show(view, with: .pushFirst(animated: false))
    }
    
}

extension AppCoordinator: Navigator {
    
    enum Destinations {
        case details(pokemon: Pokemon)
    }
    
    func navigate(to destination: AppCoordinator.Destinations) {
        switch destination {
        case .details(let pokemon):
            let presenter = PokemonDetailsPresenter(with: self, pokemon: pokemon)
            let view = PokemonDetailsViewController(with: presenter)
            presenter.view = view
            show(view, with: .push(animated: true))
        }
    }
    
}
