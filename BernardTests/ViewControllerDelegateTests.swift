//
//  ViewControllerDelegateTests.swift
//  Bernard
//
//  Created by Michael Johnson on 12/6/16.
//  Copyright © 2016 Michael Johnson. All rights reserved.
//

import XCTest
@testable import Bernard

class ViewControllerDelegateTests: XCTestCase {
    
    class FakeViewController : ViewControllerProtocol {
        var nameText : String? = nil
    }
    var fakeViewController = FakeViewController.init()
    var SUT : ViewControllerDelegate!

    override func setUp() {
        super.setUp()
        SUT = ViewControllerDelegate.init(viewController:fakeViewController)
    }
    
    func testButtonAction() {
        SUT.buttonAction()
        XCTAssertEqual(fakeViewController.nameText, "Foo")
        SUT.buttonAction()
        XCTAssertEqual(fakeViewController.nameText, "Bar")
        SUT.buttonAction()
        XCTAssertEqual(fakeViewController.nameText, "Foo")
    }
    
}
