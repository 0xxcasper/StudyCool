//
//  ConnectionManager.swift
//  StudyCool
//
//  Created by SangNX on 9/25/20.
//

import Foundation

enum NetworkType {
    case valid
    case inValid
}

class ConnectionManager {

static let sharedInstance = ConnectionManager()
private var reachability : Reachability!

func observeReachability(){
    self.reachability = try? Reachability()
    NotificationCenter.default.addObserver(self, selector:#selector(self.reachabilityChanged), name: NSNotification.Name.reachabilityChanged, object: nil)
    do {
        try self.reachability.startNotifier()
    }
    catch(let error) {
        print("Error occured while starting reachability notifications : \(error.localizedDescription)")
    }
}

@objc func reachabilityChanged(note: Notification) {
    let reachability = note.object as! Reachability
    switch reachability.connection {
    case .cellular, .wifi:
        print("Network available via Cellular Data.")
        NotificationCenter.default.post(name: .NetStatus, object: nil, userInfo: [KNET_STATUS: NetworkType.valid])
        break
    case .none, .unavailable:
        print("Network is not available.")
        NotificationCenter.default.post(name: .NetStatus, object: nil, userInfo: [KNET_STATUS: NetworkType.inValid])
        break
    }
  }
}
