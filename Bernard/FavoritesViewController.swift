//
//  FavoritesViewController.swift
//  Bernard
//
//  Created by Michael Johnson on 1/17/17.
//  Copyright © 2017 Michael Johnson. All rights reserved.
//

import UIKit

class FavoritesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, NamesModelObserving {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var clearButton: UIButton!
    @IBOutlet weak var shareButton: UIButton!
    
    private var namesModel : NamesModel? {
        if let tabBarController = tabBarController as? TabBarController {
            return tabBarController.namesModel
        }
        return nil
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let namesModelFavoritesCount = namesModel?.favorites.count {
            return namesModelFavoritesCount
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = namesModel?.favorites[indexPath.row]
        return cell
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.dataSource = self
        namesModel?.addObserver(self)
    }

    func namesModelDidUpdate() {
        self.tableView.reloadData()
    }

}
