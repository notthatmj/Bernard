//
//  FavoritesViewController.swift
//  Bernard
//
//  Created by Michael Johnson on 1/17/17.
//  Copyright © 2017 Michael Johnson. All rights reserved.
//

import UIKit

class FavoritesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, NamesModelObserving {
    
    var controller : FavoritesController!
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var clearButton: UIButton!
    @IBOutlet weak var shareButton: UIButton!
    
    @IBAction func clearButtonAction(_ sender: Any) {
        let alertController = UIAlertController(title: "Clear Favorites", message: "Are you sure you want to clear the favorites list? This action cannot be undone.", preferredStyle: UIAlertControllerStyle.actionSheet)
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.destructive) {(action: UIAlertAction) in
            return
        }
        alertController.addAction(okAction)
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel) {(action: UIAlertAction) in return
        }
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
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
