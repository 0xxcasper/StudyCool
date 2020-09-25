//
//  StudyVC.swift
//  StudyCool
//
//  Created by Sang on 9/24/20.
//

import UIKit

class StudyVC: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    // TODO: remove later
    @IBAction func onPress(_ sender: UIButton) {
        self.present(controller: TrainingViewController())
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.tintColor = #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)
    }
}
