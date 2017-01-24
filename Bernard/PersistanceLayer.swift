//
//  PersistanceLayer.swift
//  Bernard
//
//  Created by Michael Johnson on 1/21/17.
//  Copyright © 2017 Michael Johnson. All rights reserved.
//

import Foundation

class PersistanceLayer : NamesModelObserving {
    static let sharedInstance : PersistanceLayer = PersistanceLayer()
    var namesModel : NamesModelProtocol
    var archiver : Archiving? = ArchiverGateway()
    let dataFilename : String = "names-data.plist"
    
    init() {
        if let savedNamesModel = self.archiver?.unarchiveObject(withFile: self.dataFilename) as? NamesModel {
            self.namesModel = savedNamesModel
        } else {
            self.namesModel = NamesModel()
        }
        self.namesModel.addObserver(self)
    }
    
    func namesModelDidUpdate() {
//        self.archiver.archiveObject(self.namesModel.archivableState, toFile: "names-data.plist")
        _ = self.archiver?.archiveObject(self.namesModel.archivableState(), toFile: self.dataFilename)
    }
}
