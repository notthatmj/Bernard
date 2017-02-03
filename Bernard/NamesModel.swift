//
//  NamesModel.swift
//  Bernard
//
//  Created by Michael Johnson on 12/20/16.
//  Copyright © 2016 Michael Johnson. All rights reserved.
//

import Foundation

protocol NamesModelObserving {
    func namesModelDidUpdate()
}

protocol NamesModelProtocol : NSCoding {
    var currentName : String? {get}
    var currentNameIsFavorited : Bool {get set}
    var favorites : [String] {get}
    var observers : [NamesModelObserving] {get}
    var previousNameIsAvailable : Bool {get}
    
    func clearFavorites()
    func nextName() -> String
    func previousName() -> String?
    func addObserver(_ observer: NamesModelObserving)

}

class NamesModel : NSObject, NSCoding, NamesModelProtocol {

    // MARK: Initializers (excluding the initializer required by NSCoding)
    override convenience init() {
        self.init(nameGenerator : NameGenerator())
    }
    
    init(nameGenerator : NameGenerating) {
        self.nameGenerator = nameGenerator
        namesHistory = [GeneratedName]()
        super.init()
    }
    

    // MARK: NamesModelProtocol properties/methods
    var currentName : String? {
        return currentGeneratedName == nil ? nil : currentGeneratedName!.name
    }
    
    var currentNameIsFavorited : Bool {
        get { return currentGeneratedName == nil ? false : currentGeneratedName!.isFavorited }
        set {
            if currentGeneratedName != nil {
                currentGeneratedName?.isFavorited = newValue
            }
            notifyObserversOfUpdate()
        }
    }

    var favorites : [String] {
        return namesHistory.filter({$0.isFavorited}).map({$0.name})
    }

    var previousNameIsAvailable: Bool {
        if currentNameIndex ?? 0 > 0 {
            return true
        }
        return false
    }

    private(set) var observers : [NamesModelObserving] = [NamesModelObserving]()
    
    func clearFavorites() {
        for generatedName in namesHistory {
            generatedName.isFavorited = false
        }
        notifyObserversOfUpdate()
    }

    func nextName() -> String {
        if currentNameIndex == nil {
            currentNameIndex = 0
        } else {
            currentNameIndex! += 1
        }
        let createdName = nameGenerator.createName()
        let name = GeneratedName(name: createdName, isFavorited: false)
        namesHistory.append(name)
        notifyObserversOfUpdate()
        return currentName!
    }
    
    func previousName() -> String? {
        if currentNameIndex != nil && currentNameIndex! > 0 {
            currentNameIndex! -= 1
        }
        notifyObserversOfUpdate()
        return currentName
    }
    
    func addObserver(_ observer: NamesModelObserving) {
        observers.append(observer)
    }
    
    // MARK: NSCoding methods
    required public init?(coder aDecoder: NSCoder) {
        namesHistory = aDecoder.decodeObject(forKey: "namesHistory") as? [GeneratedName] ?? []
        if (namesHistory.count == 0) {
            self.currentNameIndex = nil
        } else {
            self.currentNameIndex = Int(aDecoder.decodeInt32(forKey: "currentNameIndex"))
        }
        self.nameGenerator = NameGenerator()
        super.init()
    }
    
    func encode(with aCoder: NSCoder) {
        var archivableNamesHistory = [GeneratedName]()
        for name in namesHistory {
            let archivableName = GeneratedName(name: name.name, isFavorited: name.isFavorited)
            archivableNamesHistory.append(archivableName)
        }
        aCoder.encode(archivableNamesHistory as NSArray, forKey: "namesHistory")
        aCoder.encode(currentNameIndex ?? 0, forKey: "currentNameIndex")
    }
    
    // MARK: Private
    private var nameGenerator : NameGenerating
    private var namesHistory : [GeneratedName]
    private var currentNameIndex : Int?

    private func notifyObserversOfUpdate() {
        for observer in observers {
            observer.namesModelDidUpdate()
        }
    }
    
    private var currentGeneratedName : GeneratedName? {
        return currentNameIndex == nil ? nil : namesHistory[currentNameIndex!]
    }
}

class GeneratedName : NSObject, NSCoding {
    
    let name : String
    var isFavorited : Bool
    
    init(name : String, isFavorited : Bool) {
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
        self.isFavorited = aDecoder.decodeBool(forKey: "isFavorited")
        super.init()
    }
    
}
