//
//  ArchiverGateway.swift
//  Bernard
//
//  Created by Michael Johnson on 1/21/17.
//  Copyright © 2017 Michael Johnson. All rights reserved.
//

import Foundation

protocol Archiving {
    func archiveObject(_ object: NSCoding, toFile filename:String) -> Bool
    func unarchiveObject(withFile filename:String) -> NSObject?
}

class ArchiverGateway : Archiving {

    private var dataDirectoryURL : URL?
    
    init?() {
        let directoryURLs = FileManager.default.urls(for: FileManager.SearchPathDirectory.applicationSupportDirectory,
                                                     in: FileManager.SearchPathDomainMask.userDomainMask)
        guard directoryURLs.count >= 1,
            let bundleID = Bundle.main.bundleIdentifier else {
            return nil
        }
        let appDirectoryURL = directoryURLs[0]
        dataDirectoryURL = appDirectoryURL.appendingPathComponent(bundleID)
    }

    func archiveObject(_ object: NSCoding, toFile filename:String) -> Bool {
        guard let dataDirectoryURL = self.dataDirectoryURL else {
            return false
        }
        let dataFilePath = dataDirectoryURL.appendingPathComponent(filename).path
        try? FileManager.default.createDirectory(at: dataDirectoryURL,
                                                 withIntermediateDirectories: true, attributes: nil)
        return NSKeyedArchiver.archiveRootObject(object, toFile: dataFilePath)
    }

    func unarchiveObject(withFile filename:String) -> NSObject? {
        guard let dataFilePath = dataDirectoryURL?.appendingPathComponent(filename).path else {
            return nil
        }
        return NSKeyedUnarchiver.unarchiveObject(withFile: dataFilePath) as? NSObject
    }
    
}
