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
    }
    
    func testNextNameButtonAction() {
        SUT = ViewControllerDelegate.init(viewController:fakeViewController, nameGenerator: FakeNameGenerator())
        // I want to set up a fake nameGenerator
        SUT.nextNameButtonAction()
        XCTAssertEqual(fakeViewController.nameText, "Blammo")
        SUT.nextNameButtonAction()
        XCTAssertEqual(fakeViewController.nameText, "Kablooie")
        SUT.nextNameButtonAction()
        XCTAssertEqual(fakeViewController.nameText, "Spam")
    }

    func testPreviousNameButtonAction() {
        SUT = ViewControllerDelegate(viewController:fakeViewController, nameGenerator: FakeNameGenerator())
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

}
