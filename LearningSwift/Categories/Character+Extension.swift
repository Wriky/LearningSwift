//
//  Character+Extension.swift
//  LearningSwift
//
//  Created by wangyuan on 2018/12/28.
//  Copyright © 2018 wangyuan. All rights reserved.
//

import Foundation

extension Character {
    //Converts Character to String
    public var toString: String {
        return String(self)
    }
    
    //If the character represents an integer that fits into an Int, returns the corresponding integer
    public var toInt: Int? {
        return Int(String(self))
    }
    
    //Convert the character to lowercase
    public var lowercased: Character {
        let s = String(self).lowercased()
        return s[s.startIndex]
    }
    
    //Convert the character to uppercase
    public var uppercased: Character {
        let s = String(self).uppercased()
        return s[s.startIndex]
    }
    
    //Checks if character is emoji
    var isEmoji: Bool {
        return String(self).includesEmoji()
    }
}
