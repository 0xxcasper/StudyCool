//
//  FireBase.swift
//  StudyCool
//
//  Created by SangNX on 9/24/20.
//

import Foundation
import UIKit
import FirebaseAuth
import FirebaseDatabase
import SVProgressHUD
import RealmSwift

struct Firebase {
    static let shared = Firebase()
    
    //MARK: - Authen
    
    func signIn(_ email:String,_ pass: String,_ completion:@escaping ((Bool)->())) {
        Auth.auth().signIn(withEmail: email, password: pass) { (Result, Error) in
            if Error == nil {
                completion(true)
            } else {
                completion(false)
            }
        }
    }
    
    func signUp(_ email:String,_ pass:String,_ name:String,_ completion:@escaping ((Bool)->())) {
        Auth.auth().createUser(withEmail: email, password: pass) { (Result, Error) in
            if (Error == nil) {
                guard let uid = Result?.user.uid else { return }
                let values = [ID: uid, NAME: name, EMAIL: email]
                let ref = Database.database().reference().child(USER).child(uid)
                ref.updateChildValues(values, withCompletionBlock: { (Error, Database) in
                    if (Error == nil) {
                        completion(true)
                    } else {
                        completion(false)
                    }
                })
            } else {
                completion(false)
            }
        }
    }
    
    func signOut() {
        do {
            try Auth.auth().signOut()
            AppRouter.shared.updateAppRouter()
        } catch {
            SVProgressHUD.showError(withStatus: error.localizedDescription)
        }
    }
    
    func getDataUser(_ completion: @escaping ((UserModel?)->())) {
        guard let currentId = Auth.auth().currentUser?.uid else { return }
        let ref = Database.database().reference().child(USER).child(currentId)
        ref.observeSingleEvent(of: .value) { (DataSnapshot) in
            if let data = DataSnapshot.value as? [String:AnyObject] {
                let user = UserModel(data)
                completion(user)
            } else {
                completion(nil)
            }
        }
    }
    
    func getDataTopicLearned(titleTopic: String,_ completion: @escaping (([WordLearned]?)->())) {
        guard let currentId = Auth.auth().currentUser?.uid else { return }
        let ref = Database.database().reference().child("Topics").child(currentId).child(titleTopic)
        ref.observeSingleEvent(of: .value) { (DataSnapshot) in
            if let jsonResult = DataSnapshot.value as? [Any] {
                var words: [WordLearned] = []
                jsonResult.forEach { data in
                    let word = WordLearned(data: data as! [String : AnyObject])
                    words.append(word)
                }
                completion(words)
            } else {
                completion(nil)
            }
        }
    }
    
    func setDataTopicLearned(words: [WordModel], titleTopic: String) {
        guard let currentId = Auth.auth().currentUser?.uid else { return }
        let ref = Database.database().reference().child("Topics").child(currentId).child(titleTopic)
       
        let wordsLearned = List<WordLearned>()
        for word in words {
            // Save Firebase
            let level = (word.listened && word.writen) ? word.level + 1 : word.level
            ref.child("\(word.id ?? 0)").updateChildValues(["id" : word.id ?? 0, "level": level ?? 0])
            // Save Local
            let wordLearned = WordLearned(id: word.id ?? 0, level: level ?? 0)
            wordsLearned.append(wordLearned)
        }
        TopicWordLearned.add(name: titleTopic, item: TopicWordLearned(words: wordsLearned, name: titleTopic))
    }
}

