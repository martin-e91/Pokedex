//
//  CacheTests.swift
//  PokedexTests
//
//  Created by Martin Essuman on 27/08/2020.
//  Copyright © 2020 Martino Godswill Essuman. All rights reserved.
//

import XCTest
@testable import Pokedex

class CacheTests: XCTestCase {

    func testCacheInsert() {
        let sut = Cache<Int, String>()
        sut.insert("A", forKey: 0)
        sut.insert("B", forKey: 1)
        
        XCTAssertEqual(sut.value(forKey: 0), "A")
        XCTAssertEqual(sut.value(forKey: 1), "B")
    }
    
    func testCacheMultipleInsertWithSameKey() {
        let sut = Cache<Int, String>()
        let key = 0
        sut.insert("A", forKey: key)
        
        precondition(sut.value(forKey: key) == "A")
        
        sut.insert("Z", forKey: key)
        XCTAssertEqual(sut.value(forKey: key), "Z")
    }
    
    func testCacheMultipleReading() {
        let sut = Cache<Int, String>()
        sut.insert("A", forKey: 0)

        for _ in 0..<10 {
            XCTAssertEqual(sut.value(forKey: 0), "A")
        }
    }
    
    func testCacheRetrieveNil() {
        let sut = Cache<Int, String>()
        
        for index in 0..<10 {
            XCTAssertNil(sut.value(forKey: index))
        }
    }
    
    func testCacheReset() {
        let sut = Cache<Int, String>()
        sut.insert("A", forKey: 0)
        sut.insert("B", forKey: 1)
        
        precondition(sut.value(forKey: 0) != nil)
        precondition(sut.value(forKey: 1) != nil)
        
        sut.reset()
        
        XCTAssertNil(sut.value(forKey: 0))
        XCTAssertNil(sut.value(forKey: 1))
    }
    
}
