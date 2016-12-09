//
//  NameGeneratorTests.swift
//  Bernard
//
//  Created by Michael Johnson on 12/9/16.
//  Copyright © 2016 Michael Johnson. All rights reserved.
//

import XCTest
@testable import Bernard

class NameGeneratorTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    func testNameGenerator() {
        let SUT : NameGenerator = NameGenerator()
        var name = SUT.makeName(fromValues: 5,12,17)
        XCTAssertEqual(name, "Apennin")
        name = SUT.makeName(fromValues: 16,7,8)
        XCTAssertEqual(name, "Pajenar")
    }
}
