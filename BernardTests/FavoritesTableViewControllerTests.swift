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
    let numberOfSectionsConstant : Int
    let numberOfRowsConstant : Int
    
    init(numberOfSections : Int, numberOfRows: Int) {
        self.numberOfSectionsConstant = numberOfSections
        self.numberOfRowsConstant = numberOfRows
    }
    
    func numberOfSections() -> Int {
        return numberOfSectionsConstant
    }
    
    func numberOfRows() -> Int {
        return numberOfRowsConstant
    }
}

class FavoritesTableViewControllerTests: XCTestCase {

    var SUT : FavoritesTableViewController?
    var arbitraryTableView : UITableView!
    
    override func setUp() {
        super.setUp()
        let storyboard = UIStoryboard.init(name: "Main", bundle: Bundle.main)
        SUT = storyboard.instantiateViewController(withIdentifier: "FavoritesTableViewController") as? FavoritesTableViewController
        let fakeFavoritesController = FakeFavoritesController(numberOfSections: 1, numberOfRows: 5)
        SUT?.controller = fakeFavoritesController
        arbitraryTableView = UITableView()

    }
    
    func testCanLoadViewControllerFromStoryboard() {
        XCTAssertNotNil(SUT)
    }
    
    func testNumberOfSections() {
        XCTAssertEqual(SUT?.numberOfSections(in: arbitraryTableView), 1)
    }

    func testNumberOfRows() {
        XCTAssertEqual(SUT?.tableView(arbitraryTableView, numberOfRowsInSection: 0), 5)
        
    }

}
