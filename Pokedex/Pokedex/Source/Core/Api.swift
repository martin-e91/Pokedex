//
//  Api.swift
//  Pokedex
//
//  Created by Martin Essuman on 21/08/2020.
//  Copyright © 2020 Martino Godswill Essuman. All rights reserved.
//

import Foundation
import NetworkLayer

enum Api {
    private static var baseUrl: String { "https://pokeapi.co/api/v2/" }
    
    enum Pokemon {
        case pokemon(offset: Int? = nil, limit: Int? = nil)
        
        private var path: String {
            switch self {
            case .pokemon(_, _):
                return "pokemon"
            }
        }
        
        func makeEndpoint() -> Endpoint {
            switch self {
            case .pokemon(let offset, let limit):
                let urlString = "\(Api.baseUrl)\(path)"
                var queryItems: [URLQueryItem] = []
                if let offset = offset, let limit = limit {
                    queryItems = [
                        .init(name: "offset", value: String(offset)),
                        .init(name: "limit", value: String(limit)),
                    ]
                }
                let endpoint = ConcreteEndpoint(urlString: urlString, queryParameters: queryItems)
                return endpoint
            }
        }
        
    }
    
}
