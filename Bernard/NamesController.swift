//
//  NamesController.swift
//  Bernard
//
//  Created by Michael Johnson on 12/6/16.
//  Copyright © 2016 Michael Johnson. All rights reserved.
//

import Foundation
import  UIKit

protocol NamesControllerProtocol {
    func nextNameButtonAction()
    func previousNameButtonAction()
    func favoriteToggleWasUpdatedAction()
    func viewDidLoad()
}

class NamesController : NamesControllerProtocol {
    
    var viewController : NamesViewControllerProtocol
    var tabBarController : UITabBarController? {
        return viewController.tabBarController
    }
    var namesModel : NamesModelProtocol
    
    convenience init(viewController : NamesViewControllerProtocol) {
        let tabBarController = viewController.tabBarController as? TabBarController
        var namesModel = tabBarController?.namesModel
        if namesModel == nil {
            namesModel = NamesModel()
        }
        self.init(viewController: viewController, namesModel: namesModel!)
    }

    convenience init(viewController : NamesViewControllerProtocol, nameGenerator : NameGenerating) {
        self.init(viewController: viewController,
                  namesModel: NamesModel(nameGenerator: nameGenerator))
    }

    init(viewController : NamesViewControllerProtocol, namesModel : NamesModelProtocol) {
        self.viewController = viewController
        self.namesModel = namesModel
    }
    
    func nextNameButtonAction() {
        viewController.nameText = namesModel.nextName()
        viewController.favoriteToggleIsOn = namesModel.currentNameIsFavorited
    }
    
    func previousNameButtonAction() {
        viewController.nameText = namesModel.previousName()
        viewController.favoriteToggleIsOn = namesModel.currentNameIsFavorited
    }
    
    func favoriteToggleWasUpdatedAction() {
        namesModel.currentNameIsFavorited = viewController.favoriteToggleIsOn
    }
    
    func viewDidLoad() {
        viewController.favoriteToggleIsOn = namesModel.currentNameIsFavorited
        viewController.nameText = namesModel.currentName ?? ""
    }
}
