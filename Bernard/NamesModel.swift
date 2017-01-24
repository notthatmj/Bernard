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

class ArchivableName : NSObject, NSCoding {
    let name : String
    let isFavorited : Bool
    
    init(name : String, isFavorited: Bool) {
        self.name = name
        self.isFavorited = isFavorited
        super.init()
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.name, forKey: "name")
        aCoder.encode(self.isFavorited, forKey: "isFavorited")
    }
    
    required init?(coder aDecoder: NSCoder) {
        if let name = aDecoder.decodeObject(forKey: "name") as? String {
            self.name = name
        } else {
            self.name = ""
        }
        if let isFavorited = aDecoder.decodeObject(forKey: "isFavorited") as? Bool {
            self.isFavorited = isFavorited
        } else {
            self.isFavorited = false
        }
        
        super.init()
    }
    
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

class NamesModel : NSObject, NSCoding, NamesModelProtocol {

    private var nameGenerator : NameGenerating
    private var namesHistory : [Name]
    private var currentNameIndex : Int?
    private(set) var observers : [NamesModelObserving] = [NamesModelObserving]()
    
    var favorites : [String] {
        return namesHistory.filter({$0.isFavorited}).map({$0.name})
    }
    
    var currentName : String? {
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
    
    required public init?(coder aDecoder: NSCoder) {
        if let unarchivedHistory = aDecoder.decodeObject(forKey: "namesHistory") as? [ArchivableName] {
            namesHistory = [Name]()
            for name in unarchivedHistory {
                namesHistory.append(Name(name: name.name, isFavorited: name.isFavorited))
            }
        } else {
            self.namesHistory = []
        }
        self.currentNameIndex = Int(aDecoder.decodeInt32(forKey: "currentNameIndex"))
        self.nameGenerator = NameGenerator()
        super.init()
    }

    override convenience init() {
        self.init(nameGenerator : NameGenerator())
        
    }
    
    init(nameGenerator : NameGenerating) {
        self.nameGenerator = nameGenerator
        namesHistory = [Name]()
        super.init()
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
    
    func encode(with aCoder: NSCoder) {
        var archivableNamesHistory = [ArchivableName]()
        for name in namesHistory {
            let archivableName = ArchivableName(name: name.name, isFavorited: name.isFavorited)
            archivableNamesHistory.append(archivableName)
        }
        aCoder.encode(archivableNamesHistory as NSArray, forKey: "namesHistory")
        aCoder.encode(currentNameIndex!, forKey: "currentNameIndex")
    }
    
}
