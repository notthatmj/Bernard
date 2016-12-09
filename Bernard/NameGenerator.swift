//
//  NameGenerator.swift
//  Bernard
//
//  Created by Michael Johnson on 12/9/16.
//  Copyright © 2016 Michael Johnson. All rights reserved.
//

import Foundation

protocol NameGenerating {
    func createName() -> String
}

class NameGenerator : NameGenerating {
    var count = 0
    
    func createName() -> String {
        var name : String
        switch count {
        case 0:
            name = "Blammo"
        case 1:
            name = "Kablooie"
        default:
            name = "Spam"
        }
        count += 1
        return name
    }
    
    func makeName(fromValues a : Int, _ b: Int, _ c: Int) -> String {
        return "Apennin"
    }

}
