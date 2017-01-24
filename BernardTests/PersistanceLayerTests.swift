//
//  PersistanceLayerTests.swift
//  Bernard
//
//  Created by Michael Johnson on 1/21/17.
//  Copyright © 2017 Michael Johnson. All rights reserved.
//

import XCTest
@testable import Bernard

class PersistanceLayerTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    func testInitialization() {
        let SUT = PersistanceLayer()
        
        XCTAssertEqual(SUT.namesModel.observers.count, 1)
        let observer = SUT.namesModel.observers[0] as? PersistanceLayer
        XCTAssertNotNil(observer)
        XCTAssert(observer === SUT)
    }
    
    func testNamesModelDidUpdate() {
        class FakeArchiverGateway : Archiving {
            func archiveObject(_ object: NSCoding, toFile filename: String) -> Bool {
                return false
            }
            func unarchiveObject(withFile filename: String) -> NSObject? {
                return NSObject()
            }
        }
        
        let SUT = PersistanceLayer()
        
        SUT.archiver = FakeArchiverGateway()
    }
}
