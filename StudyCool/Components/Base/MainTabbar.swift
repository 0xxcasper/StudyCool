//
//  MainTabbar.swift
//  MusicApp
//
//  Created by admin on 22/03/2020.
//  Copyright © 2020 SangNX. All rights reserved.
//

import Foundation
import UIKit
import BubbleTabBar

class MainTabbar: BubbleTabBarController {
    
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
        reviewNC.tabBarItem = CBTabBarItem(title: "Ôn tập từ vựng", image: #imageLiteral(resourceName: "gym"), tag: 0)
        reviewNC.navigationBar.prefersLargeTitles = true
        
        let studyVC = StudyVC()
        let studyNC = BaseNavigationController(rootViewController: studyVC)
        studyVC.tabBarItem = UITabBarItem(title: "Học từ vựng", image: #imageLiteral(resourceName: "learn"), tag: 1)
        studyNC.navigationBar.prefersLargeTitles = true
        
        let accountVC = AccountVC()
        let accountNC = BaseNavigationController(rootViewController: accountVC)
        accountVC.tabBarItem = UITabBarItem(title: "Thông tin tài khoản", image: #imageLiteral(resourceName: "user"), tag: 2)
        accountNC.navigationBar.prefersLargeTitles = true
        
        viewControllers = [ reviewNC, studyNC, accountNC ]
    }

}

class BaseNavigationController : UINavigationController, UIGestureRecognizerDelegate {

    override func viewDidLoad() {

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
