//
//  BernardTests.swift
//  BernardTests
//
//  Created by Michael Johnson on 12/5/16.
//  Copyright © 2016 Michael Johnson. All rights reserved.
//

import XCTest
@testable import Bernard

fileprivate class FakeController:NamesControllerProtocol {
    
    var nextNameButtonActionWasCalled = false
    var previousNameButtonActionWasCalled = false
    var updateModelWasCalled = false
    
    func nextNameButtonAction() {
        nextNameButtonActionWasCalled = true
    }
    
    func previousNameButtonAction() {
        previousNameButtonActionWasCalled = true
    }
    
    func updateModel() {
        updateModelWasCalled = true
    }
    func configureViewController() {}
    
}

class NamesViewControllerTests: XCTestCase {
    
    var viewController : NamesViewController!
    fileprivate var fakeController : FakeController!
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        let storyboard = UIStoryboard.init(name: "Main", bundle: Bundle.main)
        viewController = storyboard.instantiateViewController(withIdentifier: "NamesViewController") as? NamesViewController
        fakeController = FakeController.init()
        XCTAssertNotNil(viewController)
        viewController.controller = fakeController
    }

    func loadView() {
        _ = viewController.view
    }

    func checkThatActionName(for control: UIControl?, _ event: UIControlEvents, is name: String) {
        let actionsOptional = control?.actions(forTarget: viewController,
                                              forControlEvent: event)
        XCTAssertNotNil(actionsOptional)
        if let actions = actionsOptional {
            XCTAssertEqual(actions, [name])
        }
    }
    
    func checkThatActionName(forButton button: UIButton?, is name: String) {
        checkThatActionName(for: button, UIControlEvents.touchUpInside, is: name)
    }
    
    func checkThatActionName(for barButtonItem: UIBarButtonItem?, is name: String) {
        XCTAssert(viewController === barButtonItem?.target)
        XCTAssertEqual(barButtonItem?.action, Selector(name))
    }
    
    func testOutletsAndActionSettings() {
        loadView()
        
        XCTAssertNotNil(viewController.nextNameButton)
        checkThatActionName(for: viewController.nextNameButton, is: "nextNameButtonAction:")

        XCTAssertNotNil(viewController.nameLabel)
        
        XCTAssertNotNil(viewController.favoriteButton)
        checkThatActionName(forButton: viewController.favoriteButton, is: "favoriteButtonAction:")

        XCTAssertNotNil(viewController.previousNameButton)
        checkThatActionName(for: viewController.previousNameButton, is: "previousNameButtonAction:")
        XCTAssertNotNil(viewController.toolbar)
    }
    
    func testViewDidLoadInitializesController() {
        loadView()
        
        XCTAssertNotNil(viewController.controller)
    }
    
    func testNextNameButtonAction() {
        loadView()
        if let button = viewController.nextNameButton {
            viewController.nextNameButtonAction(button)
        }
        XCTAssertTrue(fakeController.nextNameButtonActionWasCalled);
    }

    func testPreviousNameButtonAction() {
        loadView()
        if let button = viewController.previousNameButton {
            viewController.previousNameButtonAction(button)
        }
        XCTAssertTrue(fakeController.previousNameButtonActionWasCalled);
    }

    func testNameText() {
        XCTAssertEqual(viewController.nameText,nil)
        loadView()
        let testText = "Foobar"
        viewController.nameText = testText
        XCTAssertEqual(viewController.nameText, testText)
        XCTAssertEqual(viewController.nameLabel.text, testText)
    }

    func testGetFavoriteToggleIsOn() {
        loadView()
        viewController.favoriteButton.isSelected = false
        XCTAssertEqual(viewController.favoriteToggleIsOn, false)
        viewController.favoriteButton.isSelected = true
        XCTAssertEqual(viewController.favoriteToggleIsOn, true)
    }
    
    func testSetFavoriteToggleIsOn() {
        loadView()
        viewController.favoriteToggleIsOn = false
        XCTAssertEqual(viewController.favoriteButton?.isSelected, false)
        viewController.favoriteToggleIsOn = true
        XCTAssertEqual(viewController.favoriteButton?.isSelected, true)
    }
    
}
