//
//  FavoritesControllerTests.swift
//  Bernard
//
//  Created by Michael Johnson on 1/17/17.
//  Copyright © 2017 Michael Johnson. All rights reserved.
//

import XCTest
@testable import Bernard

class FavoritesControllerTests: XCTestCase {
    
    func testClearFavoritesAction() {
        
        class FakeNamesModel : NamesModelProtocol {
            public func encode(with aCoder: NSCoder) {}
            required init?(coder aDecoder: NSCoder) {}
            init() {}
            var clearFavoritesWasCalled = false
            func clearFavorites() {
                clearFavoritesWasCalled = true
            }
            func archivableState() -> NSCoding {
                return NSArray()
            }
            func addObserver(_ observer: NamesModelObserving) {}
            func nextName() -> String { return "" }
            func previousName() -> String? { return "" }
            var currentNameIsFavorited: Bool = false
            var favorites: [String] = []
            var observers: [NamesModelObserving] = []
            var currentName: String? = nil
        }
        
        class FakeFavoritesViewController : FavoritesViewControllerProtocol {
            var dismissWasCalled = false
            func dismiss(animated flag: Bool, completion: (() -> Void)?) {
                dismissWasCalled = true
            }
        }

        let fakeNamesModel = FakeNamesModel()
        let SUT = FavoritesController(namesModel: fakeNamesModel, favoritesViewController: FakeFavoritesViewController())
        
        SUT.clearFavoritesAction()
        XCTAssertTrue(fakeNamesModel.clearFavoritesWasCalled)
    }

    func testDoneButtonAction() {
        class FakeNamesModel : NamesModelProtocol {
            public func encode(with aCoder: NSCoder) {}
            required init?(coder aDecoder: NSCoder) {}
            init() {}
            var clearFavoritesWasCalled = false
            func clearFavorites() {
                clearFavoritesWasCalled = true
            }
            func archivableState() -> NSCoding {
                return NSArray()
            }
            func addObserver(_ observer: NamesModelObserving) {}
            func nextName() -> String { return "" }
            func previousName() -> String? { return "" }
            var currentNameIsFavorited: Bool = false
            var favorites: [String] = []
            var observers: [NamesModelObserving] = []
            var currentName: String? = nil
        }
        class FakeFavoritesViewController : FavoritesViewControllerProtocol {
            var dismissWasCalled = false
            var dismissAnimatedArg : Bool? = nil
            var dismissCompletionArg: (() -> Void)? = nil
            
            func dismiss(animated flag: Bool, completion: (() -> Void)?) {
                dismissWasCalled = true
                dismissAnimatedArg = flag
                dismissCompletionArg = completion
            }
        }

        let fakeNamesModel = FakeNamesModel()
        let fakeFavoritesViewController = FakeFavoritesViewController()
        let SUT = FavoritesController(namesModel: fakeNamesModel, favoritesViewController: fakeFavoritesViewController)
        
        SUT.doneButtonAction()
        XCTAssertTrue(fakeFavoritesViewController.dismissWasCalled)
        XCTAssertTrue(fakeFavoritesViewController.dismissAnimatedArg ?? false)
        XCTAssertNil(fakeFavoritesViewController.dismissCompletionArg)
    }

}
