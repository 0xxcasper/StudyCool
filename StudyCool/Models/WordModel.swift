//
//  WordModel.swift
//  StudyCool
//
//  Created by admin on 28/09/2020.
//

import Foundation
import UIKit
import RealmSwift

class WordModel {
    
    var id: Int!
    var word: String!
    var mean: String!
    var pronunciation: String!
    var sentence: String!
    var level: Int!
    var listened: Bool!
    var writen: Bool!

    init(_ data: [String:AnyObject]) {
        id = data["id"] as? Int
        word = (data["word"] != nil) ? data["word"]!.trimmingCharacters(in: .whitespacesAndNewlines) : ""
        mean = data["mean"] as? String
        pronunciation = data["pronunciation"] as? String
        sentence = data["sentence"] as? String
        level = 0
        writen = false
        listened = false
    }
    
    func updateLevel(level: Int) {
        self.level = level
    }
}

@objcMembers class WordLearned: Object {

    dynamic var level: Int = 0
    dynamic var id: Int = 0
    
    convenience init(id: Int, level: Int) {
        self.init()
        self.level = level
        self.id = id
    }
    
    convenience init(data: [String:AnyObject]) {
        self.init()
        self.id = data["id"] as? Int ?? 0
        self.level = data["level"] as? Int ?? 0
    }
}

@objcMembers class TopicWordLearned: Object {
    dynamic var words = List<WordLearned>()
    dynamic var name: String = ""
    
    convenience init( words: List<WordLearned>, name: String) {
        self.init()
        self.words = words
        self.name = name
    }
    
}

extension TopicWordLearned {
    
    static func getAll(name: String, in realm: Realm = try! Realm()) -> List<WordLearned>? {
        let topics = realm.objects(TopicWordLearned.self)
        for topic in topics {
            if (topic.name == name) {
                return topic.words
            }
        }
        return nil
    }
    
    static func add(name: String, item: TopicWordLearned, in realm: Realm = try! Realm()) -> Void {
        let topics = realm.objects(TopicWordLearned.self)
        for topic in topics {
            if (topic.name == name) {
                topic.delete()
            }
        }
        try! realm.write {
            realm.add(item)
        }
    }
    
    func delete() {
        guard let realm = realm else { return }
        try! realm.write {
            realm.delete(self)
        }
    }
}
