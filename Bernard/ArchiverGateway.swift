//
//  ArchiverGateway.swift
//  Bernard
//
//  Created by Michael Johnson on 1/21/17.
//  Copyright © 2017 Michael Johnson. All rights reserved.
//

import Foundation

class ArchiverGateway {
    
    private func dataDirectoryURL() -> URL? {
        let sharedManager = FileManager.default
        let appDirectoryURL = sharedManager.urls(for: FileManager.SearchPathDirectory.applicationSupportDirectory,
                                                 in: FileManager.SearchPathDomainMask.userDomainMask)[0]
        if let bundleID = Bundle.main.bundleIdentifier {
            let dataDirectoryURL = appDirectoryURL.appendingPathComponent(bundleID)
            return dataDirectoryURL
        }
        
        return nil
    }

    func archive(_ t: NSObject, toFile filename:String) -> Bool {
        guard let dataDirectoryURL = dataDirectoryURL() else {
            return false
        }
            
        let dataFilePath = dataDirectoryURL.appendingPathComponent(filename).path
        try? FileManager.default.createDirectory(at: dataDirectoryURL, withIntermediateDirectories: true, attributes: nil)
        return NSKeyedArchiver.archiveRootObject(t, toFile: dataFilePath)
    }
    
    func unarchiveObjectFromFile(_ filename:String) -> NSObject? {
        if let dataDirectoryURL = dataDirectoryURL() {
            let dataFilePath = dataDirectoryURL.appendingPathComponent(filename).path
            return NSKeyedUnarchiver.unarchiveObject(withFile: dataFilePath) as? NSObject
        }
        return nil
    }
    
}
