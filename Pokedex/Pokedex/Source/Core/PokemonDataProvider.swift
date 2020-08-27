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
    typealias PokemonReferenceCompletion = (Result<PaginatedResult<ApiResource>, Error>) -> Void
    typealias PokemonCompletion = (Result<Pokemon, Error>) -> Void
    
    /// Retrieves pokemon references. The result is cached.
    /// - Parameters:
    ///   - startingIndex: The starting position for the paginated result.
    ///   - resultsPerPage: Number of expected results.
    ///   - completion: Completion block.
    func getPokemonReferences(startingIndex: Int, resultsPerPage: Int, completion: @escaping PokemonReferenceCompletion)
    
    /// Retrieves the pokemon at the given url. The result is cached.
    /// - Parameters:
    ///   - id: Id of the desired pokemon.
    ///   - completion: Completion block.
    func getPokemon(from urlString: String, completion: @escaping PokemonCompletion)
}

final class PokemonDataProvider {
    typealias PokemonDetailsCompletion = (Result<PokemonDetails, Error>) -> Void
    
    private lazy var networkClient = NetworkClient()
    private let cache = Cache<String, Any>()
    
    private func getPokemonDetails(from urlString: String, completion: @escaping PokemonDetailsCompletion) {
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
}

extension PokemonDataProvider: PokemonProvider {
    func getPokemonReferences(startingIndex: Int, resultsPerPage: Int, completion: @escaping PokemonReferenceCompletion) {
        let endpoint = Api.Pokemon.pokemon(offset: startingIndex, limit: resultsPerPage).makeEndpoint()
        let request = NetworkRequest(method: .get,
                                     endpoint: endpoint)
        
        if let url = try? endpoint.makeURL().absoluteString,
            let references = cache.value(forKey: url) as? PaginatedResult<ApiResource> {
            completion(.success(references))
        }
            
        networkClient.perform(request) { [weak self] (result: Result<PaginatedResult<ApiResource>, NetworkError>) in
            guard let self = self else { return }
            switch result {
            case .success(let references):
                completion(.success(references))
                guard let url = try? endpoint.makeURL().absoluteString else { return }
                self.cache.insert(references, forKey: url)
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func getPokemon(from urlString: String, completion: @escaping PokemonCompletion) {
        if let pokemon = cache.value(forKey: urlString) as? Pokemon {
            completion(.success(pokemon))
            return
        }
        
        getPokemonDetails(from: urlString) { [weak self] (result: Result<PokemonDetails, Error>) in
            guard let self = self else { return }
            switch result {
            case .failure(let error):
                completion(.failure(error))
            case .success(let details):
                self.download(from: details.sprites.frontDefaultUrl) { [weak self] (result: Result<Data, Error>) in
                    switch result {
                    case .failure(let error):
                        completion(.failure(error))
                    case .success(let imageData):
                        let pokemon = details.convertToPokemon(with: imageData)
                        self?.cache.insert(pokemon, forKey: urlString)
                        completion(.success(pokemon))
                    }
                }
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
