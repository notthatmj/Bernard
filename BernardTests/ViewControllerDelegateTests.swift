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
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    func testCreate() {
        class FakeViewController : ViewControllerProtocol {}
        let fakeViewController = FakeViewController.init()
        let SUT : ViewControllerDelegate = ViewControllerDelegate.init(viewController:fakeViewController);

        XCTAssertNotNil(SUT);
    }
    
}
