//
//  PokemonDataProvider.swift
//  Pokedex
//
//  Created by Martin Essuman on 21/08/2020.
//  Copyright © 2020 Martino Godswill Essuman. All rights reserved.
//

import Foundation
import NetworkLayer

protocol PokemonProvider {
    typealias PokemonReferenceCompletion = (Result<PaginatedResult<PokemonReference>, Error>) -> Void
    
    /// Retrieves pokemon references.
    /// - Parameters:
    ///   - startingIndex: The starting position for the paginated result.
    ///   - resultsPerPage: Number of expected results.
    ///   - completion: Completion block.
    func getPokemonReferences(startingIndex: Int, resultsPerPage: Int, completion: @escaping PokemonReferenceCompletion)
}

final class PokemonDataProvider {
    private lazy var networkClient = NetworkClient()
}

extension PokemonDataProvider: PokemonProvider {
    func getPokemonReferences(startingIndex: Int, resultsPerPage: Int, completion: @escaping PokemonReferenceCompletion) {
        let request = NetworkRequest(method: .get,
                                     endpoint: Api.Pokemon.pokemon(offset: startingIndex, limit: resultsPerPage))
        networkClient.perform(request) { [weak self] (result: Result<PaginatedResult<PokemonReference>, NetworkError>) in
            guard let self = self else { return }
            switch result {
            case .success(let references):
                completion(.success(references))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
