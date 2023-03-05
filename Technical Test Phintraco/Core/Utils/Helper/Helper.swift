//
//  Helper.swift
//  Technical Test Phintraco
//
//  Created by Samlo Berutu on 05/03/23.
//

import Foundation

class Helper {
    static func idFormatter(id: String) -> String {
        "#\(String(format: "%04d", Int(id) ?? 0))"
    }
    
    static func fibonancci(editedCount: Int) -> Int {
        if editedCount < 2 {
            return editedCount
        }
        var prev1 = 1
        var prev2 = 0
        var result = 0
        for _ in 2...editedCount {
            result = prev1 + prev2
            prev2 = prev1
            prev1 = result
        }
        return result
    }

}
