//
//  FavoritesController.swift
//  Bernard
//
//  Created by Michael Johnson on 1/9/17.
//  Copyright © 2017 Michael Johnson. All rights reserved.
//

import Foundation
import UIKit

protocol FavoritesControllerProtocol {
    func numberOfSections() -> Int
    func numberOfRows() -> Int
}

class FavoritesController : FavoritesControllerProtocol {
    func numberOfSections() -> Int {
        return 1
    }
    func numberOfRows() -> Int {
        return 0
    }
}
