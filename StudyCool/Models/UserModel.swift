//
//  UserModel.swift
//  StudyCool
//
//  Created by SangNX on 9/25/20.
//

import Foundation

import UIKit

struct UserModel {
    
    var id:String!
    var name:String!
    var email:String!
    
    init(_ data: [String:AnyObject]) {
        id = data["id"] as? String
        name = data["name"] as? String
        email = data["email"] as? String
    }
}
