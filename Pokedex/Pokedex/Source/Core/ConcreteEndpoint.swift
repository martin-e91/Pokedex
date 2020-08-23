//
//  ConcreteEndpoint.swift
//  Pokedex
//
//  Created by Martin Essuman on 23/08/2020.
//  Copyright © 2020 Martino Godswill Essuman. All rights reserved.
//

import Foundation
import NetworkLayer

struct ConcreteEndpoint: Endpoint {
    let urlString: String
    let queryParameters: [URLQueryItem]
    
    init(urlString: String, queryParameters: [URLQueryItem] = []) {
        self.urlString = urlString
        self.queryParameters = queryParameters
    }
    
    func makeURL() throws -> URL {
        var components = URLComponents(string: urlString)
        components?.queryItems = queryParameters
        
        guard let url = components?.url else {
            throw NetworkError.invalidURL
        }
        return url
    }
}
