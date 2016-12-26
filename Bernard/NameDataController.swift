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
    private var namesHistory : [String]
    private var currentNameIndex : Int?
    private var currentName : String? {
        get { return currentNameIndex == nil ? nil : namesHistory[currentNameIndex!] }
    }
    
    convenience init() {
        self.init(nameGenerator : NameGenerator())
        
    }
    
    init(nameGenerator : NameGenerating) {
        self.nameGenerator = nameGenerator
        self.namesHistory = [String]()
    }
    
    func nextName() -> String {
        if currentNameIndex == nil {
            currentNameIndex = 0
        } else {
            currentNameIndex! += 1
        }
        namesHistory.append(nameGenerator.createName())
        return currentName!
    }

    func previousName() -> String? {
        if currentNameIndex != nil && currentNameIndex! > 0 {
            currentNameIndex! -= 1
        }
        return currentName
    }
    
}
