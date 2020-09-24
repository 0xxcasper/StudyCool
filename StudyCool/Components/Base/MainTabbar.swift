//
//  MainTabbar.swift
//  MusicApp
//
//  Created by admin on 22/03/2020.
//  Copyright © 2020 SangNX. All rights reserved.
//

import Foundation
import UIKit

class MainTabbar: UITabBarController {
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    deinit {
        NotificationCenter.default.removeObserver(self, name: .OpenPlayBar, object: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        setUpViewController()
    }
    
    func setUpView() {
        self.navigationItem.setHidesBackButton(true, animated: true)
    }

    func setUpViewController() {

        let reviewVC = ReviewVC()
        let reviewNC = BaseNavigationController(rootViewController: reviewVC)
        reviewNC.navigationBar.prefersLargeTitles = true
        
        let studyVC = StudyVC()
        let studyNC = BaseNavigationController(rootViewController: studyVC)
        studyNC.navigationBar.prefersLargeTitles = true
        
        viewControllers = [ reviewNC, studyNC ]
    }
}

class BaseNavigationController : UINavigationController, UIGestureRecognizerDelegate {

    override func viewDidLoad() {
        interactivePopGestureRecognizer?.isEnabled = true
        interactivePopGestureRecognizer?.delegate = self

        self.navigationBar.isTranslucent = true
        self.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationBar.shadowImage = UIImage()
        self.navigationBar.tintColor = .white
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]

    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return viewControllers.count > 1
    }
}

extension UITabBar {
    override open func sizeThatFits(_ size: CGSize) -> CGSize {
        super.sizeThatFits(size)

        var sizeThatFits = super.sizeThatFits(size)
        sizeThatFits.height = AppConstant.HEIGTH_TABBAR
        return sizeThatFits
    }
}
