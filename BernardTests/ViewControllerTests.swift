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
        self.viewController = storyboard.instantiateInitialViewController() as? ViewController
    }

    func loadView(for viewController : UIViewController?) {
        _ = viewController?.view
    }
    
    func testOutletsAndActions() {
        self.loadView(for: viewController)
        XCTAssertNotNil(viewController?.button)
        XCTAssertNotNil(viewController?.nameLabel)
        XCTAssertEqual(viewController?.nameLabel?.text, "")

        if let actions = viewController?.button?.actions(forTarget: viewController,
                                                         forControlEvent: UIControlEvents.touchUpInside) {
            XCTAssertEqual(actions, ["buttonAction:"])
        }
    }
    
    func testViewDidLoadInitializesDelegate() {
        self.loadView(for: viewController)
        
        XCTAssertNotNil(viewController?.delegate)
    }
    
    func testButtonAction() {
        class FakeDelegate:ViewControllerDelegateProtocol {
            var buttonActionWasCalled = false
            
            func buttonAction() {
                buttonActionWasCalled = true
            }
        }

        let fakeDelegate = FakeDelegate.init()
        viewController?.delegate = fakeDelegate
        loadView(for: viewController)
        if let button = viewController?.button {
            viewController?.buttonAction(button)
        }
        XCTAssertTrue(fakeDelegate.buttonActionWasCalled);
    }
}
