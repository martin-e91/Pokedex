//
//  PokemonDetailsPresenter.swift
//  Pokedex
//
//  Created by Martin Essuman on 24/08/2020.
//  Copyright © 2020 Martino Godswill Essuman. All rights reserved.
//

import Foundation

protocol PokemonDetailsPresenterProtocol {
    
}

final class PokemonDetailsPresenter: BasePresenter<PokemonDetailsViewController, AppCoordinator> {
    private let pokemonDetails: PokemonDetails
    
    required init(with coordinator: AppCoordinator, pokemonDetails: PokemonDetails) {
        self.pokemonDetails = pokemonDetails
        super.init(with: coordinator)
    }
    
    @available(*, unavailable)
    required public init(with coordinator: Nav) {
        fatalError("init(with:) has not been implemented")
    }
}

extension PokemonDetailsPresenter: PokemonDetailsPresenterProtocol {
    
}
