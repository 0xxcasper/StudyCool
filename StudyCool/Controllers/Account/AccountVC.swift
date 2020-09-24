//
//  AccountVC.swift
//  StudyCool
//
//  Created by Sang on 9/24/20.
//

import UIKit
import BubbleTabBar

class AccountVC: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.tintColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
    }
}
