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
        // I want to set up a fake nameGenerator
        SUT.nameGenerator = FakeNameGenerator.init()
        SUT.nextNameButtonAction()
        XCTAssertEqual(fakeViewController.nameText, "Blammo")
        SUT.nextNameButtonAction()
        XCTAssertEqual(fakeViewController.nameText, "Kablooie")
        SUT.nextNameButtonAction()
        XCTAssertEqual(fakeViewController.nameText, "Spam")

    }
    
}
