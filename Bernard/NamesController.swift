//
//  ViewControllerDelegate.swift
//  Bernard
//
//  Created by Michael Johnson on 12/6/16.
//  Copyright © 2016 Michael Johnson. All rights reserved.
//

import Foundation
import  UIKit

protocol ControllerProtocol {
    func nextNameButtonAction()
    func previousNameButtonAction()
    func favoriteToggleWasUpdatedAction()
}

class NamesController : ControllerProtocol {
    
    var viewController : ViewControllerProtocol
    var namesModel : NamesModel
    
    convenience init(viewController : ViewControllerProtocol) {
        self.init(viewController: viewController, namesModel: NamesModel())
    }

    convenience init(viewController : ViewControllerProtocol, nameGenerator : NameGenerating) {
        self.init(viewController: viewController,
                  namesModel: NamesModel(nameGenerator: nameGenerator))
    }

    init(viewController : ViewControllerProtocol, namesModel : NamesModel) {
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
