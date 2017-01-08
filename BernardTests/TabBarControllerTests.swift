//
//  TabBarControllerTests.swift
//  Bernard
//
//  Created by Michael Johnson on 1/6/17.
//  Copyright © 2017 Michael Johnson. All rights reserved.
//

import XCTest
@testable import Bernard

class TabBarControllerTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    func testTabBarController() {
        let storyboard = UIStoryboard.init(name: "Main", bundle: Bundle.main)
        let SUT = storyboard.instantiateInitialViewController() as? UITabBarController
        XCTAssertNotNil(SUT)
        XCTAssertNotNil(SUT?.viewControllers)
        if let viewControllers = SUT?.viewControllers {
            XCTAssertEqual(viewControllers.count, 2)
            XCTAssertNotNil(viewControllers[0] as? NamesViewController)
            XCTAssertNotNil(viewControllers[1] as? FavoritesTableViewController)
        }
    }
    
}
