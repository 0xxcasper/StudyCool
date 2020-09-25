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
}

