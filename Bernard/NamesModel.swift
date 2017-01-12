//
//  NamesModel.swift
//  Bernard
//
//  Created by Michael Johnson on 12/20/16.
//  Copyright © 2016 Michael Johnson. All rights reserved.
//

import Foundation

struct Name {
    let name : String
    var isFavorited : Bool
}

class NamesModel {
    private var nameGenerator : NameGenerating
    private var namesHistory : [Name]
    private var currentNameIndex : Int?
    
    private var currentName : String? {
        get { return currentNameIndex == nil ? nil : namesHistory[currentNameIndex!].name }
    }
    
    var currentNameIsFavorited : Bool {
        get { return currentNameIndex == nil ? false : namesHistory[currentNameIndex!].isFavorited }
        set {
            if currentNameIndex != nil {
                namesHistory[currentNameIndex!].isFavorited = newValue
            }
        }
    }
    
    var count : Int {
        return namesHistory.count
    }
    
    convenience init() {
        self.init(nameGenerator : NameGenerator())
        
    }
    
    init(nameGenerator : NameGenerating) {
        self.nameGenerator = nameGenerator
        namesHistory = [Name]()
    }
    
    func nextName() -> String {
        if currentNameIndex == nil {
            currentNameIndex = 0
        } else {
            currentNameIndex! += 1
        }
        let createdName = nameGenerator.createName()
        let name = Name(name: createdName, isFavorited: false)
        namesHistory.append(name)
        return currentName!
    }

    func previousName() -> String? {
        if currentNameIndex != nil && currentNameIndex! > 0 {
            currentNameIndex! -= 1
        }
        return currentName
    }
    
    func nameAtIndex(_ index:Int) -> Name {
        let name = self.namesHistory[index]
        return name
    }
}
