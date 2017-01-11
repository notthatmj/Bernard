//
//  FavoritesTableViewControllerTests.swift
//  Bernard
//
//  Created by Michael Johnson on 1/9/17.
//  Copyright © 2017 Michael Johnson. All rights reserved.
//

import XCTest
@testable import Bernard

fileprivate class FakeViewController {}

fileprivate class FakeFavoritesController : FavoritesControllerProtocol {
    
    var tableViewCellForRowAtIndexPathWasCalled = false
    var tableView : UITableView? = nil
    var indexPath : IndexPath? = nil
    var cannedCell : UITableViewCell? = nil
    
    var viewController: AnyObject = FakeViewController()
    
    func numberOfSections() -> Int {
        return 1
    }
    
    func numberOfRows() -> Int {
        return 5
    }
    
    func tableView(_ tableView : UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        self.tableView = tableView
        self.indexPath = indexPath
        tableViewCellForRowAtIndexPathWasCalled = true
        return cannedCell!
    }
    
    func tableViewCellForRowAtIndexPathWasCalled(withTableView tableView: UITableView,
                                                 indexPath: IndexPath) -> Bool {
        if self.tableViewCellForRowAtIndexPathWasCalled &&
            self.tableView === tableView &&
            self.indexPath == indexPath {
            return true
        }
        
        return false
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
        XCTAssertNotNil(SUT?.controller.viewController)
//        XCTAssertEqual(SUT?.controller.viewController, SUT)
        XCTAssert((SUT?.controller.viewController)! === SUT!)
    }
    
    func testThatTableViewCellForRowAtDelegatesToController() {
        let fakeFavoritesController = FakeFavoritesController()
        fakeFavoritesController.cannedCell = UITableViewCell()
        SUT?.controller = fakeFavoritesController
        
        let returnValue = SUT?.tableView(arbitraryTableView, cellForRowAt: IndexPath(row: 0, section: 0))
        
        XCTAssertTrue(fakeFavoritesController.tableViewCellForRowAtIndexPathWasCalled(withTableView:arbitraryTableView, indexPath: IndexPath(row:0, section:0 )))
        XCTAssertTrue(returnValue === fakeFavoritesController.cannedCell)
        
    }
}
