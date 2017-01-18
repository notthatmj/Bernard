//
//  FavoritesController.swift
//  Bernard
//
//  Created by Michael Johnson on 1/17/17.
//  Copyright © 2017 Michael Johnson. All rights reserved.
//

import Foundation

class FavoritesController {
    let namesModel : NamesModelProtocol
    
    init(namesModel: NamesModelProtocol) {
        self.namesModel = namesModel
    }
    
    func clearFavoritesAction() {
        namesModel.clearFavorites()
    }
}
