//
//  Downloader.swift
//  Pokedex
//
//  Created by Martin Essuman on 23/08/2020.
//  Copyright © 2020 Martino Godswill Essuman. All rights reserved.
//

import Foundation

/// An entity able to fetch raw data from an url.
protocol Downloader {
    
    /// Downloads raw data from the given url.
    /// - Parameters:
    ///   - urlString: The url to contact.
    ///   - completion: Completion block.
    func download(from urlString: String, completion: @escaping (Result<Data, Error>) -> Void)
}
