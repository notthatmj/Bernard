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
    func clearFavorites()
    func shareButtonAction()
    var favorites: [String] { get }
}

class FavoritesController : FavoritesControllerProtocol, NamesModelObserving {
    func namesModelDidUpdate() {
        favoritesViewController?.reloadTableData()
    }

    let namesModel : NamesModelProtocol
    weak var favoritesViewController : FavoritesViewControllerProtocol?

    var favoritesText: String? {
        let favorites = namesModel.favorites
        return favorites.isEmpty ? nil : favorites.joined(separator: "\n")
    }
    
    init(namesModel: NamesModelProtocol, favoritesViewController: FavoritesViewControllerProtocol) {
        self.namesModel = namesModel
        self.namesModel.addObserver(self)
        self.favoritesViewController = favoritesViewController
    }
    
    func doneButtonAction() {
        favoritesViewController?.dismiss(animated: true, completion: nil)
    }
    
    func clearFavorites() {
        namesModel.clearFavorites()
    }
    
    func shareButtonAction() {
        if let favoritesString = self.favoritesText {
            favoritesViewController?.displayShareSheet(for: favoritesString)
        }
    }
    
    public var favoritesCount: Int {
        return namesModel.favorites.count
    }
    
    var favorites: [String] {
        return namesModel.favorites
    }
}
