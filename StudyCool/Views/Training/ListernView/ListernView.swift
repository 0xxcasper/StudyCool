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
    
    override func firstInit() {
        
    }
    
    override func layoutSubviews() {
        vSpeak.setViewCorner(radius: 25)
        vSpeak.setShadow(color: .gray, offSet: CGSize(width: 1, height: 1), radius: 20)
    }
    
}
