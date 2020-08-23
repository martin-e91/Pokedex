//
//  ApiTests.swift
//  PokedexTests
//
//  Created by Martin Essuman on 21/08/2020.
//  Copyright © 2020 Martino Godswill Essuman. All rights reserved.
//

import XCTest
@testable import Pokedex

class ApiTests: XCTestCase {
    
    private var expectedBaseUrl: String { "https://pokeapi.co/api/v2/" }

    func testPokemonEndpointPath() {
        guard let sut = try? Api.Pokemon.pokemon().makeEndpoint().makeURL() else { return XCTFail() }
        
        let expectedPath = "\(expectedBaseUrl)pokemon"
        XCTAssertTrue(sut.absoluteString.hasPrefix(expectedPath), "Incorrect url")
    }
    
    func testPokemonEndpointCorrectness() {
        let offsetRange: Range<Int> = 0..<Int.random(in: 1...1000)
        let limit: Int = .random(in: 1...50)
        
        for offset in offsetRange {
            guard let sut = try? Api.Pokemon.pokemon(offset: offset, limit: limit).makeEndpoint().makeURL() else { return XCTFail() }
            XCTAssertEqual(sut.absoluteString, "\(expectedBaseUrl)pokemon?offset=\(offset)&limit=\(limit)", "Incorrect url")
        }
    }

}
