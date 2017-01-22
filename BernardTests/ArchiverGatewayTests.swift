//
//  ArchiverGatewayTests.swift
//  Bernard
//
//  Created by Michael Johnson on 1/22/17.
//  Copyright © 2017 Michael Johnson. All rights reserved.
//

import XCTest
@testable import Bernard

class ArchiverGatewayTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    func testArchiverGateway() {
        let SUT = ArchiverGateway()
        let objectToArchive : NSArray = ["foo","bar"]
        
        XCTAssertTrue(SUT.archive(objectToArchive, toFile: "testArchive"))
        
        let unarchivedObject = SUT.unarchiveObjectFromFile("testArchive")
        XCTAssertEqual(objectToArchive, unarchivedObject as? NSArray)        
    }
    
}
