//
//  JsonHelper.swift
//  MusicApp
//
//  Created by admin on 29/03/2020.
//  Copyright © 2020 SangNX. All rights reserved.
//

import Foundation
import UIKit

class JsonHelper {
    
    class func readJSONFromFile(fileName: String, type: String) -> [WordModel]?
    {
        var words: [WordModel] = []
        if let path = Bundle.main.path(forResource: fileName, ofType: "json") {
            do {
                let fileUrl = URL(fileURLWithPath: path)
                let data = try Data(contentsOf: fileUrl, options: .mappedIfSafe)
                let json = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                if let jsonResult = (json as AnyObject)["\(type)"] as? [Dictionary<String, AnyObject>] {
                    jsonResult.forEach { data in
                        let word = WordModel(data)
                        words.append(word)
                    }
                    return words
                }
            } catch {
                
            }
        }
        return nil
    }

}
