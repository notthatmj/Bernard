//
//  NamesModel.swift
//  Bernard
//
//  Created by Michael Johnson on 12/20/16.
//  Copyright © 2016 Michael Johnson. All rights reserved.
//

import Foundation

class NamesModel {
    private var nameGenerator : NameGenerating
    private var namesHistory : [String]
    private var favesHistory : [Bool]
    private var currentNameIndex : Int?
    private var currentName : String? {
        get { return currentNameIndex == nil ? nil : namesHistory[currentNameIndex!] }
    }
    
    var currentNameIsFavorite : Bool {
        get { return currentNameIndex == nil ? false : favesHistory[currentNameIndex!] }
        set {
            if currentNameIndex != nil {
                favesHistory[currentNameIndex!] = newValue
            }
        }
    }
    
    convenience init() {
        self.init(nameGenerator : NameGenerator())
        
    }
    
    init(nameGenerator : NameGenerating) {
        self.nameGenerator = nameGenerator
        self.namesHistory = [String]()
        self.favesHistory = [Bool]()
    }
    
    func nextName() -> String {
        if currentNameIndex == nil {
            currentNameIndex = 0
        } else {
            currentNameIndex! += 1
        }
        namesHistory.append(nameGenerator.createName())
        favesHistory.append(false)
        return currentName!
    }

    func previousName() -> String? {
        if currentNameIndex != nil && currentNameIndex! > 0 {
            currentNameIndex! -= 1
        }
        return currentName
    }
    
}
