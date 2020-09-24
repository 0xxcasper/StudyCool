//
//  AppRouter.swift
//  StudyCool
//
//  Created by SangNX on 9/24/20.
//

import Foundation
import UIKit
import Firebase

class AppRouter {
    
    static let shared = AppRouter()
    
    func openHome() {
        guard let scene = UIApplication.shared.connectedScenes.first, let sceneDelegate : SceneDelegate = (scene.delegate as? SceneDelegate), let appWindow = sceneDelegate.window else { return }
        let rootNC = UINavigationController(rootViewController: MainTabbar())
        rootNC.setNavigationBarHidden(true, animated: true)
        appWindow.rootViewController = rootNC
    }
    
    func openLogin() {
        guard let scene = UIApplication.shared.connectedScenes.first, let sceneDelegate : SceneDelegate = (scene.delegate as? SceneDelegate), let appWindow = sceneDelegate.window else { return }
        appWindow.rootViewController = LoginViewController()
    }
    
    func updateAppRouter() {
         if (Auth.auth().currentUser?.uid != nil) {
             AppRouter.shared.openHome()
         } else {
             AppRouter.shared.openLogin()
         }
    }
}
