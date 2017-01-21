//
//  PersistanceLayerTests.swift
//  Bernard
//
//  Created by Michael Johnson on 1/21/17.
//  Copyright © 2017 Michael Johnson. All rights reserved.
//

import XCTest
@testable import Bernard

class PersistanceLayerTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    func testPersistanceLayer() {
        _ = PersistanceLayer.sharedInstance
    }
    
}
