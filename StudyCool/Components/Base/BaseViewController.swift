
//
//  BaseViewController.swift
//  MusicApp
//
//  Created by admin on 22/03/2020.
//  Copyright © 2020 SangNX. All rights reserved.
//

import UIKit


class BaseViewController: UIViewController {
    deinit {
        NotificationCenter.default.removeObserver(self, name: .NetStatus, object: nil)
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        addNetworkNotification()
    }

    func runAfterDelay(_ delay: TimeInterval, block: @escaping ()->()) {
        let time = DispatchTime.now() + Double(Int64(delay * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
        DispatchQueue.main.asyncAfter(deadline: time, execute: block)
    }
    
    func addNetworkNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(handleNetworkStatus(_:)), name: .NetStatus, object: nil)
    }
    
    @objc func handleNetworkStatus(_ notification: Notification) {
        guard let networkStatus = notification.userInfo?[KNET_STATUS] as? NetworkType else {return}
        switch networkStatus {
        case .valid:
            print("")
            break
        default:
            print("")
        }
    }
}

// MARK: For Navigation
extension BaseViewController {
    
    func push(controller: UIViewController, animated: Bool = true) {
        controller.hidesBottomBarWhenPushed = false
        self.navigationController?.pushViewController(controller, animated: animated)
    }

    func pop(animated: Bool = true ) {
        self.navigationController?.popViewController(animated: animated)
    }

    func present(controller: UIViewController, animated: Bool = true) {
        controller.modalPresentationStyle = .fullScreen
        self.present(controller, animated: animated, completion: nil)
    }

    func dismiss(animated: Bool = true) {
        self.dismiss(animated: animated, completion: nil)
    }

}
