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
    var SUT: FavoritesViewController!
    
    override func setUp() {
        super.setUp()
        let storyboard = UIStoryboard.init(name: "Main", bundle: Bundle.main)
        
        guard let SUT = storyboard.instantiateViewController(withIdentifier: "FavoritesViewController")
            as? FavoritesViewController else {
                XCTAssertTrue(false)
                return
        }
        XCTAssertNotNil(SUT)
        
        // Load the view
        _ = SUT.view
        
        self.SUT = SUT
        
    }
    
    func testDoneButtonAction() {
        // Setup
        guard let sender = SUT.doneButton else {
            XCTAssertTrue(false)
            return
        }
        
        let fakeFavoritesController = FakeFavoritesController()
        SUT.controller = fakeFavoritesController
        
        // Run
        SUT.doneButtonAction(sender)
        
        // Verify
        XCTAssertTrue(fakeFavoritesController.doneButtonActionWasCalled)
    }

    func testOutlets() {
        XCTAssertNotNil(SUT.navigationBar)
        XCTAssertNotNil(SUT.tableView)
        XCTAssertNotNil(SUT.clearButton)
        XCTAssertNotNil(SUT.shareButton)
        XCTAssertNotNil(SUT.doneButton)
    }
    
    func testPosition() {
        XCTAssertEqual(SUT.position(for: SUT.navigationBar), UIBarPosition.topAttached)
    }
    
    func testNavigationBarDelegate() {
        XCTAssert(SUT.navigationBar.delegate === SUT)
    }

}
