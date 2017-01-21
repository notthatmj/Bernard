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

extension Name : Equatable {}

func ==(lhs: Name, rhs: Name) -> Bool {
    return lhs.name == rhs.name && lhs.isFavorited == rhs.isFavorited
}

protocol NamesModelObserving {
    func namesModelDidUpdate()
}

protocol NamesModelProtocol {
    func clearFavorites()
}

class NamesModel : NamesModelProtocol {
    private var nameGenerator : NameGenerating
    private var namesHistory : [Name]
    private var currentNameIndex : Int?
    private(set) var observers : [NamesModelObserving] = [NamesModelObserving]()
    
    var favorites : [String] {
        return namesHistory.filter({$0.isFavorited}).map({$0.name})
    }
    
    private var currentName : String? {
        return currentNameIndex == nil ? nil : namesHistory[currentNameIndex!].name
    }
    
    var currentNameIsFavorited : Bool {
        get { return currentNameIndex == nil ? false : namesHistory[currentNameIndex!].isFavorited }
        set {
            if currentNameIndex != nil {
                namesHistory[currentNameIndex!].isFavorited = newValue
            }
            notifyObserversOfUpdate()
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
        notifyObserversOfUpdate()
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
    
    func addObserver(_ observer: NamesModelObserving) {
        observers.append(observer)
    }
    
    func notifyObserversOfUpdate() {
        for observer in observers {
            observer.namesModelDidUpdate()
        }
    }
    
    func clearFavorites() {
        for i in 0..<namesHistory.count {
            namesHistory[i].isFavorited = false
        }
        notifyObserversOfUpdate()
    }
    
}
