//
//  NamesModelTests.swift
//  Bernard
//
//  Created by Michael Johnson on 1/12/17.
//  Copyright © 2017 Michael Johnson. All rights reserved.
//

import XCTest
@testable import Bernard

fileprivate class Observer : NamesModelObserving {
    var updated : Bool = false
    func namesModelDidUpdate() {
        updated = true
    }
}

class NamesModelTests: XCTestCase {
    
    var SUT : NamesModel!
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        SUT = NamesModel()
    }
    
    func testAddObserver() {
        let observer = Observer()
        SUT.addObserver(observer)
        _ = SUT.nextName()
        XCTAssert(observer.updated)
    }
    
    func testFavorites() {
        _ = SUT.favorites
        XCTAssertEqual(SUT.favorites, [])
        let firstName = SUT.nextName()
        SUT.currentNameIsFavorited = true
        _ = SUT.nextName()
        let thirdName = SUT.nextName()
        SUT.currentNameIsFavorited = true
        XCTAssertEqual(SUT.favorites, [firstName, thirdName])
        
    }
    
    func testClearFavorites() {
        _ = SUT.nextName()
        SUT.currentNameIsFavorited = true
        _ = SUT.nextName()
        _ = SUT.nextName()
        SUT.currentNameIsFavorited = true
        let observer = Observer()
        SUT.addObserver(observer)
        
        SUT.clearFavorites()
        
        XCTAssertEqual(SUT.favorites, [])
        XCTAssertTrue(observer.updated)
    }
    
    func testArchiving() {
        let SUT = NamesModel()
        guard let archiver = ArchiverGateway() else {
            XCTAssert(false)
            return
        }
        
        let firstName = SUT.nextName()
        let secondName = SUT.nextName()
        SUT.currentNameIsFavorited = true
        
        XCTAssert(archiver.archive(SUT, toFile: "testData"))
        guard let unarchivedModel = archiver.unarchiveObject(withFile: "testData") as? NamesModel else {
            XCTAssertFalse(false)
            return
        }
        XCTAssertEqual(unarchivedModel.currentName, secondName)
        XCTAssertTrue(unarchivedModel.currentNameIsFavorited)
        XCTAssertEqual(unarchivedModel.previousName(), firstName)
        XCTAssertFalse(unarchivedModel.currentNameIsFavorited)
        
    }

    func testArchiveFreshModel() {
        let SUT = NamesModel()
        guard let archiver = ArchiverGateway() else {
            XCTAssert(false)
            return
        }
        
        XCTAssert(archiver.archive(SUT, toFile: "testData"))
        guard let unarchivedModel = archiver.unarchiveObject(withFile: "testData") as? NamesModel else {
            XCTAssertFalse(false)
            return
        }
        XCTAssertNil(unarchivedModel.currentName)
    }
    
    func testPreviousNameIsAvailable() {
        XCTAssertFalse(SUT.previousNameIsAvailable)
        _ = SUT.nextName()
        XCTAssertFalse(SUT.previousNameIsAvailable)
        _ = SUT.nextName()
        XCTAssert(SUT.previousNameIsAvailable)
        _ = SUT.previousName()
        XCTAssertFalse(SUT.previousNameIsAvailable)
    }

}
