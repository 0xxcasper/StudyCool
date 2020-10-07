//
//  WordModel.swift
//  StudyCool
//
//  Created by admin on 28/09/2020.
//

import Foundation
import UIKit

class WordModel {
    
    var id: Int!
    var word: String!
    var mean: String!
    var pronunciation: String!
    var sentence: String!
    var learnLevel: Int!
    var listenLevel: Int!
    var writeLevel: Int!

    init(_ data: [String:AnyObject]) {
        id = data["id"] as? Int
        word = (data["word"] != nil) ? data["word"]!.trimmingCharacters(in: .whitespacesAndNewlines) : ""
        mean = data["mean"] as? String
        pronunciation = data["pronunciation"] as? String
        sentence = data["sentence"] as? String
        learnLevel = 0
        listenLevel = 0
        writeLevel = 0
    }
}
