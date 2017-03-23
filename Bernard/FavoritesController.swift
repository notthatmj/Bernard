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
    func favoritesText() -> String?
}

class FavoritesController : FavoritesControllerProtocol {
    let namesModel : NamesModelProtocol
    weak var favoritesViewController : FavoritesViewControllerProtocol?
    
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
        if let favoritesString = self.favoritesText() {
            favoritesViewController?.displayShareSheet(for: favoritesString)
        }
    }
    
    func favoritesText() -> String? {
        let activityItems : [String]? = namesModel.favorites
        if activityItems! != [] {
            let favoritesString = activityItems?.joined(separator: "\n")
            return favoritesString
        } else {
            return nil
        }
    }

}
