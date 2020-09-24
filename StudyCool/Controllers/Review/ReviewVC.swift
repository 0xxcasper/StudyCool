//
//  ReviewVC.swift
//  StudyCool
//
//  Created by Sang on 9/24/20.
//

import UIKit

class ReviewVC: BaseViewController {

    lazy var emptyHistoryView: EmptyHistoryView = {
        let emptyView = EmptyHistoryView()
        emptyView.translatesAutoresizingMaskIntoConstraints = false
        return emptyView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let isEmptyHistory = true
        if(isEmptyHistory) {
            self.addEmptyHistoryView()
        }
    }
    
    func addEmptyHistoryView() {
        view.addSubview(emptyHistoryView)
        emptyHistoryView.fillSuperviewNotSafe()
        emptyHistoryView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.tintColor = #colorLiteral(red: 0.1579992771, green: 0.1818160117, blue: 0.5072338581, alpha: 1)
    }
}


extension ReviewVC: EmptyHistoryViewDelegate {
    func onStartLearnPress() {
        self.tabBarController?.selectedIndex = 1
    }
}
