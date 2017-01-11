//
//  FavoritesControllerTests.swift
//  Bernard
//
//  Created by Michael Johnson on 1/10/17.
//  Copyright © 2017 Michael Johnson. All rights reserved.
//

import XCTest
@testable import Bernard

class FavoritesControllerTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    func testTableViewCellForRowAt() {
        class FakeViewController {}
        let fakeViewController = FakeViewController()
        let SUT = FavoritesController(viewController: fakeViewController)
        class FakeTableView : UITableView {
            var cannedCell : UITableViewCell = UITableViewCell()
            override func dequeueReusableCell(withIdentifier identifier: String) -> UITableViewCell? {
                if identifier == "cell" {
                    return cannedCell
                }
                return nil
            }
        }
        let fakeTableView = FakeTableView()
        let cell = SUT.tableView(fakeTableView, cellForRowAt: IndexPath(row: 0, section: 0))
        XCTAssert(cell === fakeTableView.cannedCell)
    }
    
    func testTableViewCellForRowAtWithNilValue() {
        class FakeViewController {}
        let fakeViewController = FakeViewController()
        let SUT = FavoritesController(viewController: fakeViewController)
        class FakeTableView : UITableView {
            var cannedCell : UITableViewCell? = UITableViewCell()
            override func dequeueReusableCell(withIdentifier identifier: String) -> UITableViewCell? {
                if identifier == "cell" {
                    return cannedCell
                }
                return nil
            }
        }
        let fakeTableView = FakeTableView()
        let cell = SUT.tableView(fakeTableView, cellForRowAt: IndexPath(row: 0, section: 0))
        XCTAssert(cell === fakeTableView.cannedCell)
    }
}
