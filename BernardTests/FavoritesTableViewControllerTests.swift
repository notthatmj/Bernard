//
//  FavoritesTableViewControllerTests.swift
//  Bernard
//
//  Created by Michael Johnson on 1/9/17.
//  Copyright © 2017 Michael Johnson. All rights reserved.
//

import XCTest
@testable import Bernard

class FavoritesTableViewControllerTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    func testFavoritesTableViewController() {
        let storyboard = UIStoryboard.init(name: "Main", bundle: Bundle.main)
        let SUT = storyboard.instantiateViewController(withIdentifier: "FavoritesTableViewController") as? FavoritesTableViewController
        XCTAssertNotNil(SUT)
    }
    
}
