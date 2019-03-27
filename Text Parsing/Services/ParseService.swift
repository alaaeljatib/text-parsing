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
        var accumulatedStr = ""
        var returnedWords = ""
        var subLeftIndex = 0
        var accumLeftIndex = 0
        
        for i in 0...s.count {
            
            accumulatedStr = String(s[s.index(s.startIndex, offsetBy: accumLeftIndex)...s.index(s.startIndex, offsetBy: i - 1 > 0 ? i - 1 : 0)])
            subStr = String(s[s.index(s.startIndex, offsetBy: subLeftIndex)...s.index(s.startIndex, offsetBy: i - 1 > 0 ? i - 1 : 0)])
            
            if let _ = wordsDict[subStr] {
                if returnedWords.count > 0 {
                    returnedWords.append(" ")
                }
                returnedWords.append(subStr)
                if subLeftIndex > accumLeftIndex {
                    accumLeftIndex = subLeftIndex
                }
                subLeftIndex = i
            }
            if let _ = wordsDict[accumulatedStr], !returnedWords.contains(accumulatedStr) {
                if returnedWords.count > 0 {
                    returnedWords.append(" ")
                }
                returnedWords.append(accumulatedStr)
                subLeftIndex = i
                accumLeftIndex = i
            }
        }
        return returnedWords
    }
}
