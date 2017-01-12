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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var nameCount = 0
        if namesModel != nil {
            nameCount = namesModel!.favorites.count
        }
        return nameCount
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        
        if cell == nil {
            cell = UITableViewCell()
        }
        
        if namesModel != nil {
            let name = namesModel!.favorites[indexPath.row]
            cell?.textLabel?.text = name
        }

        return cell!
    }

}
