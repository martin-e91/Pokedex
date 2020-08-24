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
    private let model: PokemonReference
    private let provider: PokemonProvider
    private var pokemon: Pokemon?
    
    var title: String? {
        (pokemon?.name ?? model.name).capitalized
    }
    var image: UIImage? {
        guard let data = pokemon?.imageData else { return Assets.pokemonImagePlaceholder.image }
        return UIImage(data: data) ?? Assets.pokemonImagePlaceholder.image
    }
    
    init(model: PokemonReference, provider: PokemonProvider) {
        self.model = model
        self.provider = provider
    }
}

extension TitledImageCellViewModel: TitledImageCellViewModelProtocol {
    func prepareForReuse() {
        pokemon = nil
    }
    
    func fetchData(updateCompletion: @escaping () -> Void) {
        provider.getPokemonDetails(from: model.url) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .failure(let error):
                print(error.localizedDescription)
                updateCompletion()
            case .success(let details):
                self.fetchImage(from: details.sprites.frontDefaultUrl) { [weak self] data in
                    let imageData: Data
                    if let data = data {
                        imageData = data
                    } else {
                        imageData = Assets.pokemonImagePlaceholder.image.pngData() ?? Data()
                    }
                    self?.pokemon = Pokemon(from: details, with: imageData)
                    updateCompletion()
                }
            }
        }
        
    }
    
    private func fetchImage(from urlString: String, completion: @escaping (Data?) -> Void) {
        provider.download(from: urlString) { [weak self] result in
            switch result {
            case .failure(let error):
                print(error.localizedDescription)
                completion(nil)
            case .success(let data):
                completion(data)
            }
        }
    }
    
}
