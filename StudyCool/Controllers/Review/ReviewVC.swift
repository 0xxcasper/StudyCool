//
//  ReviewVC.swift
//  StudyCool
//
//  Created by Sang on 9/24/20.
//

import UIKit

class ReviewVC: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.tintColor = #colorLiteral(red: 0.1579992771, green: 0.1818160117, blue: 0.5072338581, alpha: 1)
    }
}