//
//  BernardTests.swift
//  BernardTests
//
//  Created by Michael Johnson on 12/5/16.
//  Copyright © 2016 Michael Johnson. All rights reserved.
//

import XCTest
@testable import Bernard

class ViewControllerTests: XCTestCase {
    
    var viewController : ViewController?

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        let storyboard = UIStoryboard.init(name: "Main", bundle: Bundle.main)
        viewController = storyboard.instantiateInitialViewController() as? ViewController
        XCTAssertNotNil(viewController)

    }

    func loadView() {
        _ = viewController?.view
    }

    func checkThatActionName(for button: UIButton?, is name: String) {
        let actionsOptional = button?.actions(forTarget: viewController,
                                              forControlEvent: UIControlEvents.touchUpInside)
        XCTAssertNotNil(actionsOptional)
        if let actions = actionsOptional {
            XCTAssertEqual(actions, [name])
        }
    }

    func testOutletsAndActionSettings() {
        loadView()
        XCTAssertNotNil(viewController?.nextNameButton)
        XCTAssertNotNil(viewController?.nameLabel)
        XCTAssertEqual(viewController?.nameLabel?.text, "")
        XCTAssertNotNil(viewController?.favoriteToggle)
        checkThatActionName(for: viewController?.nextNameButton, is: "nextNameButtonAction:")
        checkThatActionName(for: viewController?.previousNameButton, is: "previousNameButtonAction:")
        XCTAssertNotNil(viewController?.previousNameButton)
        
        let actionsOptional = viewController?.favoriteToggle?.actions(forTarget: viewController, forControlEvent: UIControlEvents.valueChanged)
        XCTAssertNotNil(actionsOptional)
        if let actions = actionsOptional {
            XCTAssertEqual(actions, ["favoriteToggleWasUpdatedAction:"])
        }
    }
    
    func testViewDidLoadInitializesDelegate() {
        loadView()
        
        XCTAssertNotNil(viewController?.delegate)
    }
    
    func testNextNameButtonAction() {
        class FakeDelegate:ViewControllerDelegateProtocol {
            var buttonActionWasCalled = false
            
            func nextNameButtonAction() {
                buttonActionWasCalled = true
            }
            
            func previousNameButtonAction() {
                buttonActionWasCalled = true
            }
            
            func favoriteToggleWasUpdatedAction() {}

        }

        let fakeDelegate = FakeDelegate.init()
        viewController?.delegate = fakeDelegate
        loadView()
        if let button = viewController?.nextNameButton {
            viewController?.nextNameButtonAction(button)
        }
        XCTAssertTrue(fakeDelegate.buttonActionWasCalled);
    }

    func testPreviousNameButtonAction() {
        
        class FakeDelegate:ViewControllerDelegateProtocol {
            var nextNameButtonActionWasCalled = false
            var previousNameButtonActionWasCalled = false
            
            func nextNameButtonAction() {
                nextNameButtonActionWasCalled = true
            }
            
            func previousNameButtonAction() {
                previousNameButtonActionWasCalled = true
            }
            func favoriteToggleWasUpdatedAction() {}

        }
        
        let fakeDelegate = FakeDelegate.init()
        viewController?.delegate = fakeDelegate
        loadView()
        if let button = viewController?.previousNameButton {
            viewController?.previousNameButtonAction(button)
        }
        XCTAssertTrue(fakeDelegate.previousNameButtonActionWasCalled);
    }

    func testFavoriteToggleWasUpdatedAction() {
        
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
        
        let fakeDelegate = FakeDelegate.init()
        viewController?.delegate = fakeDelegate
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
    
    func testFavoriteToggle() {
        loadView()
        if let isOn = viewController?.favoriteToggle?.isOn {
            XCTAssertFalse(isOn)
        } else {
            XCTFail("`viewController?.favoriteToggle?.isOn` was `nil`")
        }
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
