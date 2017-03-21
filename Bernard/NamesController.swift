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
    func updateModel()
    func configureViewController()
    
}

class NamesController : NamesControllerProtocol, NamesModelObserving {
    
    weak var viewController : NamesViewControllerProtocol?
    
    var namesModel : NamesModelProtocol
    
    convenience init(viewController : NamesViewControllerProtocol) {
        self.init(viewController: viewController, namesModel: PersistanceLayer.sharedInstance.namesModel)
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
        viewController?.nameText = namesModel.nextName()
    }
    
    func previousNameButtonAction() {
        viewController?.nameText = namesModel.previousName()
    }
    
    func configureViewController() {
        viewController?.favoriteToggleIsOn = namesModel.currentNameIsFavorited
        namesModel.addObserver(self)
        if namesModel.currentName == nil {
            _ = namesModel.nextName()
        } else {
            namesModelDidUpdate()
        }
    }
    
    func updateViewController() {
        viewController?.favoriteToggleIsOn = namesModel.currentNameIsFavorited
        viewController?.nameText = namesModel.currentName
        viewController?.previousNameButtonIsEnabled = namesModel.previousNameIsAvailable
    }

    func updateModel() {
        guard viewController != nil else {
            return
        }
        namesModel.currentNameIsFavorited = viewController!.favoriteToggleIsOn
    }

    func namesModelDidUpdate() {
        updateViewController()
    }
}
