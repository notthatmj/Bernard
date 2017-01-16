//
//  FavoritesTableViewController.swift
//  Bernard
//
//  Created by Michael Johnson on 1/8/17.
//  Copyright © 2017 Michael Johnson. All rights reserved.
//

import UIKit

class FavoritesTableViewController: UITableViewController, NamesModelObserving {

    private var namesModel : NamesModel? {
        get {
            if let tabBarController = tabBarController as? TabBarController {
                return tabBarController.namesModel
            }
            return nil
        }
    }
    
    func namesModelDidUpdate() {
        self.tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        namesModel?.addObserver(self)
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let namesModelFavoritesCount = namesModel?.favorites.count {
            return namesModelFavoritesCount
        }
        return 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = namesModel?.favorites[indexPath.row]
        return cell
    }

}
