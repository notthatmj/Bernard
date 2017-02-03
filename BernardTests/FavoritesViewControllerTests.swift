//
//  FavoritesViewControllerTests.swift
//  Bernard
//
//  Created by Michael Johnson on 1/31/17.
//  Copyright © 2017 Michael Johnson. All rights reserved.
//

import XCTest
@testable import Bernard

class FakeFavoritesController : FavoritesControllerProtocol {
    var doneButtonActionWasCalled = false
    func clearFavoritesAction() {}
    func doneButtonAction() {
        doneButtonActionWasCalled = true
    }
}

class FavoritesViewControllerTests: XCTestCase {
    
    func testFavoritesViewController() {
        // Setup
        let storyboard = UIStoryboard.init(name: "Main", bundle: Bundle.main)
        
        guard let SUT = storyboard.instantiateViewController(withIdentifier: "FavoritesViewController")
            as? FavoritesViewController else {
                XCTAssertTrue(false)
                return
        }
        XCTAssertNotNil(SUT)
        
        _ = SUT.view
        
        guard let sender = SUT.doneButton else {
            XCTAssertTrue(false)
            return
        }
        
        let fakeFavoritesController = FakeFavoritesController()
        SUT.controller = fakeFavoritesController
        SUT.doneButtonAction(sender)
        XCTAssertTrue(fakeFavoritesController.doneButtonActionWasCalled)
    }

    func testOutlets() {
        // Setup
        let storyboard = UIStoryboard.init(name: "Main", bundle: Bundle.main)
        
        guard let SUT = storyboard.instantiateViewController(withIdentifier: "FavoritesViewController")
            as? FavoritesViewController else {
                XCTAssertTrue(false)
                return
        }
        XCTAssertNotNil(SUT)
        
        // Load the view
        _ = SUT.view
        
        XCTAssertNotNil(SUT.navigationBar)
    }

}
