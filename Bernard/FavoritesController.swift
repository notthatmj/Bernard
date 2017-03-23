//
//  FavoritesController.swift
//  Bernard
//
//  Created by Michael Johnson on 1/17/17.
//  Copyright © 2017 Michael Johnson. All rights reserved.
//

import Foundation

protocol FavoritesControllerProtocol {
    func doneButtonAction()
    func clearFavoritesAction()
    func shareButtonAction()
    var favoritesText: String? { get }
}

class FavoritesController : FavoritesControllerProtocol {
    let namesModel : NamesModelProtocol
    weak var favoritesViewController : FavoritesViewControllerProtocol?

    var favoritesText: String? {
        let activityItems : [String]? = namesModel.favorites
        if activityItems! != [] {
            let favoritesString = activityItems?.joined(separator: "\n")
            return favoritesString
        } else {
            return nil
        }
    }
    
    init(namesModel: NamesModelProtocol, favoritesViewController: FavoritesViewControllerProtocol) {
        self.namesModel = namesModel
        self.favoritesViewController = favoritesViewController
    }
    
    func doneButtonAction() {
        favoritesViewController?.dismiss(animated: true, completion: nil)
    }
    
    func clearFavoritesAction() {
        namesModel.clearFavorites()
    }
    
    func shareButtonAction() {
        if let favoritesString = self.favoritesText {
            favoritesViewController?.displayShareSheet(for: favoritesString)
        }
    }
    
}
