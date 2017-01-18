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
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    func testFavoritesController() {
        
        class FakeNamesModel : NamesModelProtocol {
            var clearFavoritesWasCalled = false
            func clearFavorites() {
                clearFavoritesWasCalled = true
            }
        }
        
        let fakeNamesModel = FakeNamesModel()
        let SUT = FavoritesController(namesModel: fakeNamesModel)
        
        SUT.clearFavoritesAction()
        XCTAssertTrue(fakeNamesModel.clearFavoritesWasCalled)
    }

}
