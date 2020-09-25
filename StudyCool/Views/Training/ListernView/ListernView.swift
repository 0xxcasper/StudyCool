//
//  ListernView.swift
//  StudyCool
//
//  Created by admin on 25/09/2020.
//

import Foundation
import UIKit

class ListernView: BaseViewXib {
   
    @IBOutlet weak var vSpeak: UIView!
    @IBOutlet weak var txfAnswer: UITextField!
    @IBOutlet weak var boxView: UIView!
    @IBOutlet weak var blurView: UIVisualEffectView!
    
    override func firstInit() {
        
    }
    
    override func layoutSubviews() {
        vSpeak.setViewCorner(radius: 25)
        vSpeak.setShadow(color: .gray, offSet: CGSize(width: 1, height: 1), radius: 20)
        boxView.layer.cornerRadius = 8
        boxView.setShadow(color: #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1), offSet: CGSize(width: 1, height: 1), radius: 5)
        blurView.layer.cornerRadius = 10
        blurView.layer.masksToBounds = true
    }
    
}
