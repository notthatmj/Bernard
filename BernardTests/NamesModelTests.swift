//
//  NamesModelTests.swift
//  Bernard
//
//  Created by Michael Johnson on 1/12/17.
//  Copyright © 2017 Michael Johnson. All rights reserved.
//

import XCTest
@testable import Bernard

class NamesModelTests: XCTestCase {
    
    var SUT : NamesModel!
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        SUT = NamesModel()
    }
    
    func testNameAtIndex() {
        let SUT = NamesModel()
        let firstName = SUT.nextName()
        let secondName = SUT.nextName()
        XCTAssertEqual(SUT.nameAtIndex(0).name,firstName)
        XCTAssertEqual(SUT.nameAtIndex(1).name,secondName)
    }

    func testCount() {
        let SUT = NamesModel()
        XCTAssertEqual(SUT.count,0)
        _ = SUT.nextName()
        XCTAssertEqual(SUT.count,1)
        _ = SUT.nextName()
        XCTAssertEqual(SUT.count,2)
    }

}
