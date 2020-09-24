//
//  PopUpHelper.swift
//  StudyCool
//
//  Created by SangNX on 9/24/20.
//

import Foundation
import UIKit

struct PopUpHelper {

    static let shared = PopUpHelper()
    
    func showAlertWithTextField( _ vc: UIViewController,_ title: String = kEmpty,_ message: String = kEmpty, placeHolder: String = kEmpty,_ completion: @escaping (String)->Void) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)

        alert.addTextField { (textField) in
            textField.placeholder = placeHolder
        }

        alert.addAction(UIAlertAction(title: kOK, style: .default, handler: { [weak alert] (_) in
            let textField = alert!.textFields![0]
            if let text = textField.text, !text.isEmpty {
                completion(text)
            }
        }))
        
        vc.present(alert, animated: true, completion: nil)
    }
}
