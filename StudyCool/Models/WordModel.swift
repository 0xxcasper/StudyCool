//
//  WordModel.swift
//  StudyCool
//
//  Created by admin on 28/09/2020.
//

import Foundation
import UIKit

class WordModel {
    
    var id: String!
    var word: String!
    var mean: String!
    var pronunciation: String!
    var sentence: String!
    var isLearn: Bool!

    init(_ data: [String:AnyObject]) {
        id = data["id"] as? String
        word = (data["word"] != nil) ? data["word"]!.trimmingCharacters(in: .whitespacesAndNewlines) : ""
        mean = data["mean"] as? String
        pronunciation = data["pronunciation"] as? String
        sentence = data["sentence"] as? String
        isLearn = false
    }
}
