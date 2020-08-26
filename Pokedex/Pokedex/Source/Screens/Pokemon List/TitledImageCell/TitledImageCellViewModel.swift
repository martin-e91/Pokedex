//
//  TitledImageCellViewModel.swift
//  Pokedex
//
//  Created by Martin Essuman on 23/08/2020.
//  Copyright © 2020 Martino Godswill Essuman. All rights reserved.
//

import UIKit

protocol TitledImageCellViewModelProtocol {
    var title: String? { get }
    var image: UIImage? { get }
    
    func prepareForReuse()
    func fetchData(updateCompletion: @escaping () -> Void)
}

class TitledImageCellViewModel {
    private let model: ApiResource
    private let provider: PokemonProvider
    private var pokemon: Pokemon?
    
    var title: String? {
        (pokemon?.name ?? model.name).capitalized
    }
    var image: UIImage? {
        guard let data = pokemon?.imageData else { return Assets.pokemonImagePlaceholder.image }
        return UIImage(data: data) ?? Assets.pokemonImagePlaceholder.image
    }
    
    init(model: ApiResource, provider: PokemonProvider) {
        self.model = model
        self.provider = provider
    }
}

extension TitledImageCellViewModel: TitledImageCellViewModelProtocol {
    func prepareForReuse() {
        pokemon = nil
    }
    
    func fetchData(updateCompletion: @escaping () -> Void) {
        provider.getPokemon(from: model.url) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .failure(let error):
                print(error.localizedDescription)
                updateCompletion()
            case .success(let pokemon):
                self.pokemon = pokemon
                updateCompletion()
            }
        }
        
    }
    
}
