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
    func buttonAction()
}

class ViewControllerDelegate : ViewControllerDelegateProtocol {
    
    var viewController : ViewControllerProtocol
    
    init(viewController : ViewControllerProtocol) {
        self.viewController = viewController
    }
    
    func buttonAction() {
    }
}
