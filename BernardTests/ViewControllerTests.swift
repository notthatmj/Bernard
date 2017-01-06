//
//  BernardTests.swift
//  BernardTests
//
//  Created by Michael Johnson on 12/5/16.
//  Copyright © 2016 Michael Johnson. All rights reserved.
//

import XCTest
@testable import Bernard

class FakeDelegate:ViewControllerDelegateProtocol {
    
    var nextNameButtonActionWasCalled = false
    var previousNameButtonActionWasCalled = false
    var favoriteToggleWasUpdatedActionWasCalled = false
    
    func nextNameButtonAction() {
        nextNameButtonActionWasCalled = true
    }
    
    func previousNameButtonAction() {
        previousNameButtonActionWasCalled = true
    }
    
    func favoriteToggleWasUpdatedAction() {
        favoriteToggleWasUpdatedActionWasCalled = true
    }
    
}

class ViewControllerTests: XCTestCase {
    
    var viewController : ViewController?
    var fakeDelegate : FakeDelegate!
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        let storyboard = UIStoryboard.init(name: "Main", bundle: Bundle.main)
        viewController = storyboard.instantiateInitialViewController() as? ViewController
        fakeDelegate = FakeDelegate.init()
        XCTAssertNotNil(viewController)
        viewController?.delegate = fakeDelegate
    }

    func loadView() {
        _ = viewController?.view
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
    
    func checkThatActionName(forSwitch aSwitch: UISwitch?, is name: String) {
        checkThatActionName(for: aSwitch, UIControlEvents.valueChanged, is: name)
    }
    
    func testOutletsAndActionSettings() {
        loadView()
        
        XCTAssertNotNil(viewController?.nextNameButton)
        checkThatActionName(forButton: viewController?.nextNameButton, is: "nextNameButtonAction:")

        XCTAssertNotNil(viewController?.nameLabel)
        XCTAssertEqual(viewController?.nameLabel?.text, "")
        
        XCTAssertNotNil(viewController?.favoriteToggle)
        checkThatActionName(forSwitch: viewController?.favoriteToggle, is: "favoriteToggleWasUpdatedAction:")

        XCTAssertNotNil(viewController?.previousNameButton)
        checkThatActionName(forButton: viewController?.previousNameButton, is: "previousNameButtonAction:")
    }
    
    func testViewDidLoadInitializesDelegate() {
        loadView()
        
        XCTAssertNotNil(viewController?.delegate)
    }
    
    func testNextNameButtonAction() {
        loadView()
        if let button = viewController?.nextNameButton {
            viewController?.nextNameButtonAction(button)
        }
        XCTAssertTrue(fakeDelegate.nextNameButtonActionWasCalled);
    }

    func testPreviousNameButtonAction() {
        loadView()
        if let button = viewController?.previousNameButton {
            viewController?.previousNameButtonAction(button)
        }
        XCTAssertTrue(fakeDelegate.previousNameButtonActionWasCalled);
    }

    func testFavoriteToggleWasUpdatedAction() {
        loadView()
        if let favoriteToggle = viewController?.favoriteToggle {
            viewController?.favoriteToggleWasUpdatedAction(favoriteToggle)
        }
        XCTAssertTrue(fakeDelegate.favoriteToggleWasUpdatedActionWasCalled)
    }

    
    func testNameText() {
        XCTAssertEqual(viewController?.nameText,nil)
        loadView()
        XCTAssertEqual(viewController?.nameText,"")
        let testText = "Foobar"
        viewController?.nameText = testText
        XCTAssertEqual(viewController?.nameText, testText)
        XCTAssertEqual(viewController?.nameLabel.text, testText)
    }
    
    func testGetFavoriteToggleIsOn() {
        loadView()
        viewController?.favoriteToggle?.isOn = false
        XCTAssertEqual(viewController?.favoriteToggleIsOn, false)
        viewController?.favoriteToggle?.isOn = true
        XCTAssertEqual(viewController?.favoriteToggleIsOn, true)
    }

    func testSetFavoriteToggleIsOn() {
        loadView()
        viewController?.favoriteToggleIsOn = false
        XCTAssertEqual(viewController?.favoriteToggle?.isOn, false)
        viewController?.favoriteToggleIsOn = true
        XCTAssertEqual(viewController?.favoriteToggle?.isOn, true)
    }
    
}
