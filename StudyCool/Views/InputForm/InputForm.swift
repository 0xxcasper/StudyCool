//
//  InputForm.swift
//  StudyCool
//
//  Created by Sang on 9/25/20.
//

import Foundation
import UIKit

class InputForm: BaseViewXib {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var valueView: UIView!
    @IBOutlet weak var valueLabel: UILabel!
    
    override func firstInit() {
        titleLabel.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 0.8002461473)
        valueLabel.textColor = #colorLiteral(red: 0.5129050612, green: 0.5092011094, blue: 0.515743196, alpha: 1)
        valueView.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 0.4249518408).cgColor
        valueView.layer.borderWidth = 1
        valueView.layer.cornerRadius = 4
    }
    
    func setUpView(title: String, value: String) {
        titleLabel.text = title
        valueLabel.text = value
    }
}
