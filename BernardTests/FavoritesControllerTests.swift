//
//  FavoritesControllerTests.swift
//  Bernard
//
//  Created by Michael Johnson on 1/17/17.
//  Copyright © 2017 Michael Johnson. All rights reserved.
//

import XCTest
@testable import Bernard

class FavoritesControllerTests: XCTestCase {
    
    func testFavoritesController() {
        
        class FakeNamesModel : NamesModelProtocol {
            public func encode(with aCoder: NSCoder) {}
            required init?(coder aDecoder: NSCoder) {}
            init() {}
            var clearFavoritesWasCalled = false
            func clearFavorites() {
                clearFavoritesWasCalled = true
            }
            func archivableState() -> NSCoding {
                return NSArray()
            }
            func addObserver(_ observer: NamesModelObserving) {}
            func nextName() -> String { return "" }
            func previousName() -> String? { return "" }
            var currentNameIsFavorited: Bool = false
            var favorites: [String] = []
            var observers: [NamesModelObserving] = []
            var currentName: String? = nil
        }
        
        let fakeNamesModel = FakeNamesModel()
        let SUT = FavoritesController(namesModel: fakeNamesModel)
        
        SUT.clearFavoritesAction()
        XCTAssertTrue(fakeNamesModel.clearFavoritesWasCalled)
    }

}
