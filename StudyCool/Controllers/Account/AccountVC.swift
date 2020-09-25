//
//  AccountVC.swift
//  StudyCool
//
//  Created by Sang on 9/24/20.
//

import UIKit
import BubbleTabBar
import SVProgressHUD

class AccountVC: BaseViewController {

    @IBOutlet weak var boxView: UIView!
    @IBOutlet weak var buttonLogout: PMSuperButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        handleSignoutAction()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.tintColor = #colorLiteral(red: 0.9411764741, green: 0.4980392158, blue: 0.3529411852, alpha: 1)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupBoxView()
    }
    
    //Mark: Setup View
    func setupBoxView() {
        boxView.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        boxView.layer.cornerRadius = 10
        boxView.setShadow(color: #colorLiteral(red: 0.9411764741, green: 0.4980392158, blue: 0.3529411852, alpha: 1), opacity: 0.7, offSet: CGSize(width: 0, height: 0), radius: 3)
    }
    
    //Mark: Action
    func handleSignoutAction() {
        buttonLogout.touchUpInside {
            let alertView = SCLAlertView()
            alertView.addButton(kAccept, backgroundColor: #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1), textColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)) {
                Firebase.shared.signOut()
            }
            alertView.showWarning(kWarning, subTitle: kLogoutMessage, closeButtonTitle: kClose, colorStyle: 0xF9D96A, colorTextButton: 0xFFFFFF)
        }
    }
}
