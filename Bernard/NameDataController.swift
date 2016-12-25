//
//  NameDataController.swift
//  Bernard
//
//  Created by Michael Johnson on 12/20/16.
//  Copyright © 2016 Michael Johnson. All rights reserved.
//

import Foundation

class NameDataController {
    private var nameGenerator : NameGenerating

    convenience init() {
        self.init(nameGenerator : NameGenerator())
        
    }
    init(nameGenerator : NameGenerating) {
        self.nameGenerator = nameGenerator
    }
    func nextName() -> String {
        return nameGenerator.createName()
    }
}
