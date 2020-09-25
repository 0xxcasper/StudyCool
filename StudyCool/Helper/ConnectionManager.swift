//
//  ConnectionManager.swift
//  StudyCool
//
//  Created by SangNX on 9/25/20.
//

import Foundation

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
    case .cellular:
        print("Network available via Cellular Data.")
        break
    case .wifi:
        print("Network available via WiFi.")
        break
    case .none:
        print("Network is not available.")
        break
    case .unavailable:
        print("Network is  unavailable.")
        break
    }
  }
}
