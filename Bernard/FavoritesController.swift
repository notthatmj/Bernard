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
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell

    var viewController : AnyObject { get }

}

class FavoritesController : FavoritesControllerProtocol {

    var viewController : AnyObject
    
    init(viewController: AnyObject) {
        self.viewController = viewController
    }
    
    func numberOfSections() -> Int {
        return 1
    }
    
    func numberOfRows() -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        if cell == nil {
            cell = UITableViewCell()
        }
        return cell!
    }
    
}
