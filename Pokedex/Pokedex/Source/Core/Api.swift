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
    
    enum Pokemon: Endpoint {
        case pokemon(offset: Int, limit: Int)
        
        private var path: String {
            switch self {
            case .pokemon(_, _):
                return "pokemon"
            }
        }
        
        func makeURL() throws -> URL {
            switch self {
            case .pokemon(let offset, let limit):
                let urlString = "\(Api.baseUrl)\(path)"
                let endpoint = ConcreteEndpoint(urlString: urlString, queryParameters: [
                    .init(name: "offset", value: String(offset)),
                    .init(name: "limit", value: String(limit)),
                ])
                return try endpoint.makeURL()
            }
        }
    }
    
}
