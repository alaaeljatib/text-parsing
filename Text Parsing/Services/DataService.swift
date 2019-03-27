//
//  DataService.swift
//  Text Parsing
//
//  Created by Alaa Eljatib Etmaz Alsebaei on 2019-03-27.
//  Copyright © 2019 Alaa Eljatib Etmaz Alsebaei. All rights reserved.
//

import Foundation

class DataService {
    static let instance = DataService()
    
    func provideWordsDictionary() -> [String:String] {
        return ["apple":"", "pie":"", "shoe":"", "second": "", "secondary": ""]
    }
}
