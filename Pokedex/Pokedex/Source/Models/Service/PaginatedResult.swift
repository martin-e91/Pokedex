//
//  PaginatedResult.swift
//  Pokedex
//
//  Created by Martin Essuman on 23/08/2020.
//  Copyright © 2020 Martino Godswill Essuman. All rights reserved.
//

import Foundation

/// A paginated result for the Pokemon Api, containing information about the cursor and the set of results.
struct PaginatedResult<T>: Decodable where T: Decodable {
    /// Total objects count.
    let count: Int
    
    /// The url string for the next page.
    let next: String
    
    /// The url string for the previous page.
    let previous: String
    
    /// The set of results.
    let results: [T]
}
