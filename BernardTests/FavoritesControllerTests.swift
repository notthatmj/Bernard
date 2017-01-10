//
//  FavoritesControllerTests.swift
//  Bernard
//
//  Created by Michael Johnson on 1/10/17.
//  Copyright © 2017 Michael Johnson. All rights reserved.
//

import XCTest
@testable import Bernard

class FavoritesControllerTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    func testExample() {
    }
    
    func testNumberOfRows() {
        let SUT = FavoritesController()
        XCTAssertEqual(SUT.numberOfRows(),0)
    }
}
