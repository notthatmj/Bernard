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
        let firstName = SUT.nextName()
        let secondName = SUT.nextName()
        XCTAssertEqual(SUT.nameAtIndex(0).name,firstName)
        XCTAssertEqual(SUT.nameAtIndex(1).name,secondName)
    }

    func testCount() {
        XCTAssertEqual(SUT.count,0)
        _ = SUT.nextName()
        XCTAssertEqual(SUT.count,1)
        _ = SUT.nextName()
        XCTAssertEqual(SUT.count,2)
    }

    
    func testAddObserver() {
        class Observer : NamesModelObserving {
            var updated : Bool = false
            func namesModelDidUpdate() {
                updated = true
            }
        }
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
        class Observer : NamesModelObserving {
            var updated : Bool = false
            func namesModelDidUpdate() {
                updated = true
            }
        }
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
    
}
