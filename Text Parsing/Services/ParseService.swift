//
//  ParseService.swift
//  Text Parsing
//
//  Created by Alaa Eljatib Etmaz Alsebaei on 2019-03-27.
//  Copyright © 2019 Alaa Eljatib Etmaz Alsebaei. All rights reserved.
//

import Foundation

class ParseService {
    static let instance = ParseService()
    
    func parse(content s: String, wordsDict: [String: String]) -> String {
        guard s.count > 0 else {return ""}
        
        var subStr = ""
        var accumStr = ""
        var returnedWords = ""
        var leftIndex = 0
        
        for i in 0...s.count {
            
            accumStr = String(s[...s.index(s.startIndex, offsetBy: i - 1 > 0 ? i - 1 : 0)])
            subStr = String(s[s.index(s.startIndex, offsetBy: leftIndex)...s.index(s.startIndex, offsetBy: i - 1 > 0 ? i - 1 : 0)])
            
            if let _ = wordsDict[subStr] {
                returnedWords.append(subStr + " ")
                leftIndex = i
            }
            if let _ = wordsDict[accumStr], !returnedWords.contains(accumStr) {
                returnedWords.append(accumStr + " ")
                leftIndex = i
            }
        }
        return returnedWords
    }
}
