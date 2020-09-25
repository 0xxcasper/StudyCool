//
//  TrainingViewController.swift
//  StudyCool
//
//  Created by admin on 25/09/2020.
//

import UIKit

class TrainingViewController: BaseViewController {
    
    @IBOutlet weak var progressView: UIProgressView!
    
    @IBOutlet weak var vLearn: LearnView!
    @IBOutlet weak var vListern: ListernView!
    @IBOutlet weak var vWrite: WriteView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpView()
    }
    
    private func setUpView() {
        progressView.layer.cornerRadius = 10
        progressView.transform = progressView.transform.scaledBy(x: 1, y: 8)
        
        vLearn.isHidden = true
        vListern.isHidden = true
    }

}
