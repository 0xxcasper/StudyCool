//
//  ListernView.swift
//  StudyCool
//
//  Created by admin on 25/09/2020.
//

import Foundation
import UIKit

protocol ListernViewDelegate: class {
    func textFieldEditing(_ isEmpty: Bool)
}

class ListernView: BaseViewXib, UITextFieldDelegate {
   
    @IBOutlet weak var vSpeak: UIView!
    @IBOutlet weak var txfAnswer: UITextField!
    @IBOutlet weak var boxView: UIView!
    @IBOutlet weak var blurView: UIVisualEffectView!
    
    weak var delegate: ListernViewDelegate!
    
    var word: WordModel?{
        didSet{
            if word != nil {
                
            }
        }
    }
    
    override func firstInit() {
        txfAnswer.delegate = self
    }
    
    override func layoutSubviews() {
        vSpeak.setViewCorner(radius: 25)
        vSpeak.setShadow(color: .gray, offSet: CGSize(width: 1, height: 1), radius: 20)
        boxView.layer.cornerRadius = 8
        boxView.setShadow(color: #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1), offSet: CGSize(width: 1, height: 1), radius: 5)
        blurView.layer.cornerRadius = 10
        blurView.layer.masksToBounds = true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if (range == NSRange(location: 0, length: 1)) {
            delegate.textFieldEditing(true)
        } else {
            delegate.textFieldEditing(false)
        }
        return true
    }
    
    @IBAction func onPressSpeak(_ sender: Any) {
        if let word = word {
            LanguageHelper.speakMessage(string: word.word)
        }
    }
}
