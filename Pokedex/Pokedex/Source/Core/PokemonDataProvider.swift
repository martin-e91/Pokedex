//
//  PokemonDataProvider.swift
//  Pokedex
//
//  Created by Martin Essuman on 21/08/2020.
//  Copyright © 2020 Martino Godswill Essuman. All rights reserved.
//

import Foundation
import NetworkLayer

protocol PokemonProvider: Downloader {
    typealias PokemonReferenceCompletion = (Result<PaginatedResult<PokemonReference>, Error>) -> Void
    typealias PokemonDetailsCompletion = (Result<PokemonDetails, Error>) -> Void
    
    /// Retrieves pokemon references.
    /// - Parameters:
    ///   - startingIndex: The starting position for the paginated result.
    ///   - resultsPerPage: Number of expected results.
    ///   - completion: Completion block.
    func getPokemonReferences(startingIndex: Int, resultsPerPage: Int, completion: @escaping PokemonReferenceCompletion)
    
    /// Retrieves details for the pokemon with the given id.
    /// - Parameters:
    ///   - id: Id of the desired pokemon.
    ///   - completion: Completion block.
    func getPokemonDetails(from urlString: String, completion: @escaping PokemonDetailsCompletion)
}

final class PokemonDataProvider {
    private lazy var networkClient = NetworkClient()
}

extension PokemonDataProvider: PokemonProvider {
    func getPokemonReferences(startingIndex: Int, resultsPerPage: Int, completion: @escaping PokemonReferenceCompletion) {
        let request = NetworkRequest(method: .get,
                                     endpoint: Api.Pokemon.pokemon(offset: startingIndex, limit: resultsPerPage).makeEndpoint())
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
    
    func getPokemonDetails(from urlString: String, completion: @escaping PokemonDetailsCompletion) {
        let request = NetworkRequest(urlString: urlString)
        networkClient.perform(request) { [weak self] (result: Result<PokemonDetails, NetworkError>) in
            guard let self = self else { return }
            switch result {
            case .failure(let error):
                completion(.failure(error))
            case .success(let details):
                completion(.success(details))
            }
        }
    }

    func download(from urlString: String, completion: @escaping (Result<Data, Error>) -> Void) {
        networkClient.download(from: urlString) { [weak self] (result: Result<Data, NetworkError>) in
            guard let self = self else { return }
            switch result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
