//
//  PersistanceLayer.swift
//  Bernard
//
//  Created by Michael Johnson on 1/21/17.
//  Copyright © 2017 Michael Johnson. All rights reserved.
//

import Foundation

class PersistanceLayer {
    static let sharedInstance : PersistanceLayer = PersistanceLayer()
    var namesModel = NamesModel()
}
