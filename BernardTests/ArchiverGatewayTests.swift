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
        guard let SUT = ArchiverGateway() else {
            XCTAssert(false)
            return
        }
        
//        let SUT = ArchiverGateway()
        let objectToArchive : NSArray = ["foo","bar"]
        
        XCTAssertTrue(SUT.archiveObject(objectToArchive, toFile: "testArchive"))
        let unarchivedObject = SUT.unarchiveObject(withFile: "testArchive")
        
        XCTAssertEqual(objectToArchive, unarchivedObject as? NSArray)        
    }
    
}
