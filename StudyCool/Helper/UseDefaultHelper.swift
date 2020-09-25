//
//  UseDefaultHelper.swift
//  MusicApp
//
//  Created by admin on 22/03/2020.
//  Copyright © 2020 SangNX. All rights reserved.
//

import Foundation
import UIKit

private enum UserDefaultHelperKey: String {
    case user = "user"
}

class UserDefaultHelper {
    static let shared = UserDefaultHelper()
    private let userDefaultManager = UserDefaults.standard

    var userInfo: UserModel? {
        get {
            guard let user = get(key: .user) as? UserModel else { return nil }
            return user
        }
        set(userInfo) {
            save(value: userInfo, key: .user)
        }
    }
}

extension UserDefaultHelper {
    private func save(value: Any?, key: UserDefaultHelperKey) {
        if let _data = value {
            do {
                let data = try NSKeyedArchiver.archivedData(withRootObject: _data, requiringSecureCoding: false)
                userDefaultManager.set(data, forKey: key.rawValue)
                userDefaultManager.synchronize()

            } catch {
                print("Error")
            }
        }
    }

    private func get(key: UserDefaultHelperKey) -> Any? {
        if let data = userDefaultManager.data(forKey: key.rawValue) {
            return try! NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data)
        } else {
            return nil
        }
    }

    private func delete(key: UserDefaultHelperKey) {
        userDefaultManager.removeObject(forKey: key.rawValue)
    }

}
