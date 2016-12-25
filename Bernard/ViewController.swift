//
//  ViewController.swift
//  Bernard
//
//  Created by Michael Johnson on 12/5/16.
//  Copyright © 2016 Michael Johnson. All rights reserved.
//

import UIKit

protocol ViewControllerProtocol {
    var nameText : String? {get set}
}

class ViewController: UIViewController, ViewControllerProtocol {

    @IBOutlet weak var previousNameButton: UIButton!
    @IBOutlet weak var nextNameButton: UIButton!
    @IBOutlet weak var nameLabel: UILabel!
    
    var delegate : ViewControllerDelegateProtocol!
    
    var nameText : String? {
        get {
            return nameLabel?.text
        }
        set {
            nameLabel?.text = newValue
        }
    }
    
    @IBAction func nextNameButtonAction(_ sender: UIButton) {
        delegate.nextNameButtonAction()
    }

    @IBAction func previousNameButtonAction(_ sender: UIButton) {
        delegate.previousNameButtonAction()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        if delegate == nil {
            delegate = ViewControllerDelegate.init(viewController:self)
        }
    }

}

