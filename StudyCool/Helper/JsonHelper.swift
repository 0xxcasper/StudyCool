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
                return nil
            }
        }
        return nil
    }
    
    class func mapJSONFileWithLocalOrFirebase(fileName: String, type: String,_ completion: @escaping (([WordModel]?)->())) {
        if let words = self.readJSONFromFile(fileName: fileName, type: type) {
            if let wordLearneds = TopicWordLearned.getAll(name: type), wordLearneds.count > 0 {
                // Map level from Local
                var newWords: [WordModel] = []
                words.forEach { word in
                    let wordLearned = wordLearneds.first(where: {$0.id == word.id})

                    if let levelWord = wordLearned?.level {
                        if (levelWord < 5) {
                            word.updateLevel(level: levelWord)
                            newWords.append(word)
                        }
                    } else {
                        newWords.append(word)
                    }
                }
                completion(newWords)
            } else {
                // Map level from Firebase
                Firebase.shared.getDataTopicLearned(titleTopic: type) { (WordLearneds) in
                    if let wordLearneds = WordLearneds {
                        var newWords: [WordModel] = []
                        words.forEach { word in
                            let wordLearned = wordLearneds.first(where: {$0.id == word.id})
                            if let levelWord = wordLearned?.level {
                                if (levelWord < 5) {
                                    word.updateLevel(level:  levelWord)
                                    newWords.append(word)
                                }
                            } else {
                                newWords.append(word)
                            }
                        }
                        completion(newWords)
                    } else {
                        completion(words)
                    }
                }
                if !Reachability2.isConnectedToNetwork(){
                    completion(words)
                }
            }
        } else {
            completion(nil)
        }
    }
}

// Reachability2

import SystemConfiguration

public class Reachability2 {

    class func isConnectedToNetwork() -> Bool {

        var zeroAddress = sockaddr_in(sin_len: 0, sin_family: 0, sin_port: 0, sin_addr: in_addr(s_addr: 0), sin_zero: (0, 0, 0, 0, 0, 0, 0, 0))
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)

        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }

        var flags: SCNetworkReachabilityFlags = SCNetworkReachabilityFlags(rawValue: 0)
        if SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) == false {
            return false
        }
        // Working for Cellular and WIFI
        let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
        let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
        let ret = (isReachable && !needsConnection)

        return ret

    }
}
