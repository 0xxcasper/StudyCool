//
//  SuccessView.swift
//  StudyCool
//
//  Created by admin on 29/09/2020.
//

import Foundation
import UIKit

class SuccessView: BaseViewXib {
    @IBOutlet weak var vBG: UIView!
    @IBOutlet weak var lblMean: UILabel!
    @IBOutlet weak var lblPronoun: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblExample: UILabel!
    
    override func firstInit() {
        vBG.layer.cornerRadius = 15
    }
    var word: WordModel?{
        didSet{
            if word != nil {
                lblTitle.text = word?.word
                lblPronoun.text = word?.pronunciation
                lblMean.text = word?.mean
                lblExample.text = word?.sentence
            }
        }
    }
    
    @IBAction func onPressSpeak(_ sender: Any) {
        if let word = word {
            LanguageHelper.speakMessage(string: word.word)
        }
    }
    
}
