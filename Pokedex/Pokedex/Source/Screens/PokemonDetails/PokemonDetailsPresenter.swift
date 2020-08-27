//
//  PokemonDetailsPresenter.swift
//  Pokedex
//
//  Created by Martin Essuman on 24/08/2020.
//  Copyright © 2020 Martino Godswill Essuman. All rights reserved.
//

import UIKit

protocol PokemonDetailsPresenterProtocol {
    var screenTitle: String { get }
    var image: UIImage { get }
    var name: String { get }
}

final class PokemonDetailsPresenter: BasePresenter<PokemonDetailsViewController, AppCoordinator> {
    private let pokemon: Pokemon
    
    required init(with coordinator: AppCoordinator, pokemon: Pokemon) {
        self.pokemon = pokemon
        super.init(with: coordinator)
    }
    
    @available(*, unavailable)
    required public init(with coordinator: Nav) {
        fatalError("init(with:) has not been implemented")
    }
}

extension PokemonDetailsPresenter: PokemonDetailsPresenterProtocol {
    var screenTitle: String { pokemon.name.capitalized }
    
    var image: UIImage {
        guard let image = UIImage(data: pokemon.imageData) else { return Assets.pokemonImagePlaceholder.image }
        return image
    }
    
    var name: String { pokemon.name.capitalized }
}
