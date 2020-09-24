//
//  EmptyHistoryView.swift
//  StudyCool
//
//  Created by Sang on 9/24/20.
//

import Foundation
import UIKit


protocol EmptyHistoryViewDelegate: class {
    func onStartLearnPress()
}

class EmptyHistoryView: BaseViewXib {

    @IBOutlet weak var buttonStartLearn: PMSuperButton!
    
    weak var delegate: EmptyHistoryViewDelegate?

    override func firstInit() {
        buttonStartLearn.touchUpInside { [self] in
            self.runAfterDelay(0.3) {
                self.delegate?.onStartLearnPress()
            }
        }
    }
}

