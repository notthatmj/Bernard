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
        
        checkThatActionName(for: viewController?.nextNameButton, is: "nextNameButtonAction:")
        checkThatActionName(for: viewController?.previousNameButton, is: "previousNameButtonAction:")
        XCTAssertNotNil(viewController?.previousNameButton)
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
        }

        let fakeDelegate = FakeDelegate.init()
        viewController?.delegate = fakeDelegate
        loadView()
        if let button = viewController?.nextNameButton {
            viewController?.nextNameButtonAction(button)
        }
        XCTAssertTrue(fakeDelegate.buttonActionWasCalled);
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
}
