//
//  ViewControllerDelegate.swift
//  Bernard
//
//  Created by Michael Johnson on 12/6/16.
//  Copyright © 2016 Michael Johnson. All rights reserved.
//

import Foundation
import  UIKit

protocol ViewControllerDelegateProtocol {
    func nextNameButtonAction()
}

class ViewControllerDelegate : ViewControllerDelegateProtocol {
    
    var viewController : ViewControllerProtocol
    var nameDataController : NameDataController
    
    convenience init(viewController : ViewControllerProtocol) {
        self.init(viewController: viewController, nameDataController: NameDataController())
    }

    convenience init(viewController : ViewControllerProtocol, nameGenerator : NameGenerating) {
        self.init(viewController: viewController,
                  nameDataController: NameDataController(nameGenerator: nameGenerator))
    }

    init(viewController : ViewControllerProtocol, nameDataController : NameDataController) {
        self.viewController = viewController
        self.nameDataController = nameDataController
    }
    
    func nextNameButtonAction() {
        viewController.nameText = nameDataController.nextName()
    }
    
    func previousNameButtonAction() {
        
    }
}
