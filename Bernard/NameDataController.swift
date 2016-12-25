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
    private var _previousName : String?
    private var _currentName : String?
    
    convenience init() {
        self.init(nameGenerator : NameGenerator())
        
    }
    
    init(nameGenerator : NameGenerating) {
        self.nameGenerator = nameGenerator
    }
    
    func nextName() -> String {
        _previousName = _currentName
        let nextName = nameGenerator.createName()
        _currentName = nextName
        return nextName
    }
    
    func previousName() -> String? {
        if _previousName != nil {
            _currentName = _previousName
        }
        return _currentName
    }
    
}
