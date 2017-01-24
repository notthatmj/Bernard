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
        class FakeNamesModel : NamesModelProtocol {
            func clearFavorites() {}
            func archivableState() -> NSCoding {
                return NSString.init(string: "Test state")
            }
            func addObserver(_ observer: NamesModelObserving) {}
            func nextName() -> String { return "" }
            func previousName() -> String? { return "" }
            var currentNameIsFavorited: Bool = false
            var favorites: [String] = []
            var observers: [NamesModelObserving] = []
            var currentName: String? = nil
        }
        
        class FakeArchiverGateway : Archiving {
            var archivedObject : NSCoding? = nil
            var archiveFilename : String? = nil
            
            func archiveObject(_ object: NSCoding, toFile filename: String) -> Bool {
                archivedObject = object
                archiveFilename = filename
                return true
            }
            
            func unarchiveObject(withFile filename: String) -> NSObject? {
                return NSObject()
            }
        }
        
        let SUT = PersistanceLayer()
        let fakeArchiver = FakeArchiverGateway()
        SUT.archiver = fakeArchiver
        let fakeNamesModel = FakeNamesModel()
        SUT.namesModel = fakeNamesModel
        SUT.namesModelDidUpdate()
        
        XCTAssertNotNil(fakeArchiver.archivedObject)
        XCTAssertEqual(fakeArchiver.archiveFilename, SUT.dataFilename)
        XCTAssertEqual(fakeArchiver.archivedObject as? NSString, NSString.init(string: "Test state"))
    }
}
