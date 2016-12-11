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
        var firstSyllable : String
        switch a {
        case 1..<5:
            firstSyllable = ""
        case 5:
            firstSyllable = "a"
        case 6:
            firstSyllable = "be"
        case 7:
            firstSyllable = "de"
        case 8:
            firstSyllable = "el"
        case 9:
            firstSyllable = "fa"
        case 10:
            firstSyllable = "jo"
        case 11:
            firstSyllable = "ki"
        case 12:
            firstSyllable = "la"
        case 13:
            firstSyllable = "ma"
        case 14:
            firstSyllable = "na"
        case 15:
            firstSyllable = "o"
        case 16:
            firstSyllable = "pa"
        case 17:
            firstSyllable = "re"
        case 18:
            firstSyllable = "si"
        case 19:
            firstSyllable = "ta"
        default:
            firstSyllable = "va"
        }
        var secondSyllable : String
        switch b {
        case 1:
            secondSyllable = "bar"
        case 2:
            secondSyllable = "ched"
        case 3:
            secondSyllable = "dell"
        case 4:
            secondSyllable = "far"
        case 5:
            secondSyllable = "gran"
        case 6:
            secondSyllable = "hal"
        case 7:
            secondSyllable = "jen"
        case 8:
            secondSyllable = "kel"
        case 9:
            secondSyllable = "lim"
        case 10:
            secondSyllable = "mor"
        case 11:
            secondSyllable = "net"
        case 12:
            secondSyllable = "penn"
        case 13:
            secondSyllable = "quil"
        case 14:
            secondSyllable = "rond"
        case 15:
            secondSyllable = "sark"
        case 16:
            secondSyllable = "shen"
        case 17:
            secondSyllable = "tur"
        case 18:
            secondSyllable = "vash"
        case 19:
            secondSyllable = "yor"
        default:
            secondSyllable = "zen"
        }
        var thirdSyllable : String = ""
        switch c {
        case 1:
            thirdSyllable = ""
        case 2:
            thirdSyllable = "a"
        case 3:
            thirdSyllable = "ac"
        case 4:
            thirdSyllable = "ai"
        case 5:
            thirdSyllable = "al"
        case 6:
            thirdSyllable = "am"
        case 7:
            thirdSyllable = "an"
        case 8:
            thirdSyllable = "ar"
        case 9:
            thirdSyllable = "ea"
        case 10:
            thirdSyllable = "el"
        case 11:
            thirdSyllable = "er"
        case 12:
            thirdSyllable = "ess"
        case 13:
            thirdSyllable = "ett"
        case 14:
            thirdSyllable = "ic"
        case 15:
            thirdSyllable = "id"
        case 16:
            thirdSyllable = "il"
        case 17:
            thirdSyllable = "in"
        case 18:
            thirdSyllable = "is"
        case 19:
            thirdSyllable = "or"
        default:
            thirdSyllable = "us"
        }
        let lowerCaseName = firstSyllable + secondSyllable + thirdSyllable
        let capitalizedFirstLetter = String(lowerCaseName.characters.prefix(1)).capitalized
        let remainingLetters = String(lowerCaseName.characters.dropFirst())
        let name = capitalizedFirstLetter + remainingLetters
        return name
    }
    
}
