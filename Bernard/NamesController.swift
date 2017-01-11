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
}

class NamesController : NamesControllerProtocol {
    
    var viewController : NamesViewControllerProtocol
    var tabBarController : TabBarController? {
        return viewController.tabBarController as? TabBarController
    }
    var namesModel : NamesModel
    
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

    init(viewController : NamesViewControllerProtocol, namesModel : NamesModel) {
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
}
