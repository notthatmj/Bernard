//
//  ViewController.swift
//  Bernard
//
//  Created by Michael Johnson on 12/5/16.
//  Copyright © 2016 Michael Johnson. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var nameLabel: UILabel!
    var delegate : ViewControllerDelegateProtocol!
    
    @IBAction func buttonAction(_ sender: UIButton) {
        delegate.buttonAction()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if delegate == nil {
            delegate = ViewControllerDelegate.init()
        }
    }

}

