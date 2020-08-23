//
//  TitledImageCellViewModel.swift
//  Pokedex
//
//  Created by Martin Essuman on 23/08/2020.
//  Copyright © 2020 Martino Godswill Essuman. All rights reserved.
//

import Foundation

protocol TitledImageCellViewModelProtocol {
    func prepareForReuse()
}

struct TitledImageCellViewModel {
    private let model: PokemonReference
    private let provider: PokemonProvider
    
    init(model: PokemonReference, provider: PokemonProvider) {
        self.model = model
        self.provider = provider
    }
}

extension TitledImageCellViewModel: TitledImageCellViewModelProtocol {
    func prepareForReuse() {
        
    }
}
