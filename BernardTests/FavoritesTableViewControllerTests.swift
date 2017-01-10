//
//  FavoritesTableViewControllerTests.swift
//  Bernard
//
//  Created by Michael Johnson on 1/9/17.
//  Copyright © 2017 Michael Johnson. All rights reserved.
//

import XCTest
@testable import Bernard

fileprivate class FakeFavoritesController : FavoritesControllerProtocol {
    
    func numberOfSections() -> Int {
        return 1
    }
    
    func numberOfRows() -> Int {
        return 5
    }
}

class FavoritesTableViewControllerTests: XCTestCase {

    var SUT : FavoritesTableViewController?
    var arbitraryTableView : UITableView!
    
    override func setUp() {
        super.setUp()
        let storyboard = UIStoryboard.init(name: "Main", bundle: Bundle.main)
        SUT = storyboard.instantiateViewController(withIdentifier: "FavoritesTableViewController") as? FavoritesTableViewController
        arbitraryTableView = UITableView()

    }
    
    func testCanLoadViewControllerFromStoryboard() {
        XCTAssertNotNil(SUT)
    }
    
    func testNumberOfSections() {
        SUT?.controller = FakeFavoritesController()
        XCTAssertEqual(SUT?.numberOfSections(in: arbitraryTableView), 1)
    }

    func testNumberOfRows() {
        SUT?.controller = FakeFavoritesController()
        XCTAssertEqual(SUT?.tableView(arbitraryTableView, numberOfRowsInSection: 0), 5)
    }

    func testThatViewDidLoadInitializesControllerIfItsNil() {
        XCTAssertNil(SUT?.controller)
        SUT?.viewDidLoad()
        XCTAssertNotNil(SUT?.controller)
    }
    
    func testThatViewDidLoadLeavesControllerAloneIfItsNotNil() {
        
    }
}
