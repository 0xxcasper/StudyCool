//
//  LearnView.swift
//  StudyCool
//
//  Created by admin on 25/09/2020.
//

import Foundation
import UIKit

class LearnView: BaseViewXib {
    @IBOutlet weak var vSpeak: UIView!
    @IBOutlet weak var vBackground: UIView!
    
    @IBOutlet weak var lblWord: UILabel!
    @IBOutlet weak var lblPronoun: UILabel!
    @IBOutlet weak var lblSub: UILabel!
    
    var word: WordModel?{
        didSet{
            if word != nil {
                lblWord.text = word?.word
                lblPronoun.text = word?.pronunciation
                lblSub.text = word?.mean
            }
        }
    }
    
    override func firstInit() {
        
    }
    
    override func layoutSubviews() {
        vSpeak.setViewCorner(radius: 25)
        vSpeak.setShadow(color: .gray, offSet: CGSize(width: 1, height: 1), radius: 20)
        vBackground.setViewCorner(radius: 10)
        self.setShadow(color: #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1), offSet: CGSize(width: 1, height: 1), radius: 5)
        self.setViewCorner(radius: 10)
    }
}

