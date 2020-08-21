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
        guard let sut = try? Api.Pokemon.pokemon().makeURL() else { return XCTFail() }
        
        let expectedPath = "\(expectedBaseUrl)pokemon"
        XCTAssertTrue(sut.absoluteString.hasPrefix(expectedPath), "Incorrect url")
        
        let expectedPathWithDefaultValues = "\(expectedPath)?offset=20&limit=20"
        XCTAssertEqual(sut.absoluteString, expectedPathWithDefaultValues, "Incorrect url")
    }
    
    func testPokemonEndpointCorrectness() {
        let offsetRange: Range<UInt> = 0..<UInt.random(in: 1...1000)
        let limit: UInt = .random(in: 1...50)
        
        for offset in offsetRange {
            guard let sut = try? Api.Pokemon.pokemon(offset: offset, limit: limit).makeURL() else { return XCTFail() }
            XCTAssertEqual(sut.absoluteString, "\(expectedBaseUrl)pokemon?offset=\(offset)&limit=\(limit)", "Incorrect url")
        }
    }

}
