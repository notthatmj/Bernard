//
//  FavoritesViewController.swift
//  Bernard
//
//  Created by Michael Johnson on 1/17/17.
//  Copyright © 2017 Michael Johnson. All rights reserved.
//

import UIKit


protocol FavoritesViewControllerProtocol : class {
    func dismiss(animated flag: Bool, completion: (() -> Void)?)
    func displayShareSheet(for aString:String)
    func reloadTableData()
}

class FavoritesNavigationBarDelegate: NSObject, UINavigationBarDelegate {
    func position(for bar: UIBarPositioning) -> UIBarPosition {
        return UIBarPosition.topAttached
    }
}

class FavoritesViewController: UIViewController, UITableViewDataSource,
UITableViewDelegate, UINavigationBarDelegate, FavoritesViewControllerProtocol {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var clearButton: UIButton!
    @IBOutlet weak var shareButton: UIButton!
    @IBOutlet weak var doneButton: UIBarButtonItem!
    @IBOutlet weak var navigationBar: UINavigationBar!

    lazy var controller : FavoritesControllerProtocol! =
        FavoritesController(namesModel: PersistanceLayer.sharedInstance.namesModel,
                            favoritesViewController: self)
    
    @IBAction func clearButtonAction(_ sender: Any) {
        requestConfirmationAndClearFavorites()
    }

    @IBAction func shareButtonAction(_ sender: UIButton) {
        self.controller.shareButtonAction()
    }
    
    @IBAction func doneButtonAction(_ sender: UIBarButtonItem) {
        self.controller.doneButtonAction()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.dataSource = self
        self.navigationBar.delegate = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.controller.favorites.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = controller.favorites[indexPath.row]
        return cell
    }
    
    func position(for bar: UIBarPositioning) -> UIBarPosition {
        return UIBarPosition.topAttached
    }
    
    func reloadTableData() {
        self.tableView.reloadData()
    }

    func requestConfirmationAndClearFavorites() {
        let title = "Clear Favorites"
        let message = "Are you sure you want to clear the favorites list? This action can't be undone."
        
        let confirmationController = UIAlertController(title: title,
                                                            message: message,
                                                            preferredStyle: UIAlertControllerStyle.actionSheet)
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.destructive) {(action: UIAlertAction) in
            self.controller.clearFavorites()
        }
        confirmationController.addAction(okAction)
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel) 
        confirmationController.addAction(cancelAction)
        self.present(confirmationController, animated: true, completion: nil)
    }
    
    func displayShareSheet(for aString:String) {
        let activityViewController = UIActivityViewController(activityItems: [aString],
                                                              applicationActivities: nil)
        self.present(activityViewController, animated: true, completion: nil)
    }
    

}
