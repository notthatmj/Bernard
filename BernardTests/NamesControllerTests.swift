//
//  ViewControllerDelegateTests.swift
//  Bernard
//
//  Created by Michael Johnson on 12/6/16.
//  Copyright © 2016 Michael Johnson. All rights reserved.
//

import XCTest
@testable import Bernard

class NamesControllerTests: XCTestCase {
    
    class FakeViewController : NamesViewControllerProtocol {
        var nameText : String? = nil
        var favoriteToggleIsOn: Bool = false
        var tabBarController: UITabBarController? = nil
        var previousNameButtonIsEnabled: Bool = true
    }
    
    var fakeViewController = FakeViewController.init()
    var SUT : NamesController!

    class FakeNameGenerator : NameGenerating {
        var count = 0
        func createName() -> String {
            var name : String
            switch count {
            case 0:
                name = "Blammo"
            case 1:
                name = "Kablooie"
            default:
                name = "Spam"
            }
            count += 1
            return name
        }
    }

    override func setUp() {
        super.setUp()
        SUT = NamesController.init(viewController:fakeViewController, nameGenerator: FakeNameGenerator())
    }
    
    func testNextNameButtonAction() {
        SUT.nextNameButtonAction()
        XCTAssertEqual(fakeViewController.nameText, "Blammo")
        SUT.nextNameButtonAction()
        XCTAssertEqual(fakeViewController.nameText, "Kablooie")
        SUT.nextNameButtonAction()
        XCTAssertEqual(fakeViewController.nameText, "Spam")
    }

    func testThatFavoritesAreRemembered() {
        SUT.configureViewController()
        XCTAssertFalse(fakeViewController.favoriteToggleIsOn)
        SUT.nextNameButtonAction()

        // First name
        XCTAssertFalse(fakeViewController.favoriteToggleIsOn)
        fakeViewController.favoriteToggleIsOn = true
        SUT.updateModel()
        SUT.nextNameButtonAction()
        
        // Second name
        XCTAssertFalse(fakeViewController.favoriteToggleIsOn)
        SUT.nextNameButtonAction()
        
        // Third name
        XCTAssertFalse(fakeViewController.favoriteToggleIsOn)
        fakeViewController.favoriteToggleIsOn = true
        SUT.updateModel()
        SUT.previousNameButtonAction()
        
        // Second name
        XCTAssertFalse(fakeViewController.favoriteToggleIsOn)
        SUT.previousNameButtonAction()
        
        // First name
        XCTAssertTrue(fakeViewController.favoriteToggleIsOn)
        SUT.nextNameButtonAction()
        
        // Second name
        XCTAssertFalse(fakeViewController.favoriteToggleIsOn)
        SUT.nextNameButtonAction()

        // Third name
        XCTAssertTrue(fakeViewController.favoriteToggleIsOn)
    }

    func testPreviousNameButtonAction() {
        SUT.previousNameButtonAction()
        XCTAssertEqual(fakeViewController.nameText, nil)
        SUT.nextNameButtonAction()
        SUT.nextNameButtonAction()
        SUT.nextNameButtonAction()
        SUT.previousNameButtonAction()
        XCTAssertEqual(fakeViewController.nameText, "Kablooie")
        SUT.previousNameButtonAction()
        XCTAssertEqual(fakeViewController.nameText, "Blammo")
    }
    
    func testConfigureViewControllerWithPreloadedModel() {
        // Setup
        let namesModel = NamesModel()
        _ = namesModel.nextName()
        let secondName = namesModel.nextName()
        namesModel.currentNameIsFavorited = true
        SUT.namesModel = namesModel

        // Test
        SUT.configureViewController()

        // Assert
        guard let viewController = SUT.viewController else {
            XCTAssert(false)
            return
        }
        XCTAssertEqual(viewController.nameText, secondName)
        XCTAssertEqual(viewController.favoriteToggleIsOn, true)
        XCTAssertTrue(viewController.previousNameButtonIsEnabled)
    }

    func testConfigureViewControllerWithFreshModel() {
        // Test
        SUT.configureViewController()
        
        // Assert
        guard let viewController = SUT.viewController else {
            XCTAssert(false)
            return
        }
        XCTAssertNotNil(viewController.nameText)
        XCTAssertNotEqual(viewController.nameText, "")
        XCTAssertFalse(viewController.favoriteToggleIsOn)
        XCTAssertFalse(viewController.previousNameButtonIsEnabled)
    }

    func testFavoritesToggleChangesWhenNamesCleared() {
        SUT.configureViewController()
        _ = SUT.nextNameButtonAction()
        fakeViewController.favoriteToggleIsOn = true
        SUT.updateModel()
        SUT.namesModel.clearFavorites()
        XCTAssertFalse(fakeViewController.favoriteToggleIsOn)
    }
    
}
