//
//  String+Extension.swift
//  BrowserApp
//
//  Created by admin on 25/11/2019.
//  Copyright © 2019 nxsang063@gmail.com. All rights reserved.
//

import Foundation
import UIKit


extension Notification.Name {
     static let ChangeLanguage = Notification.Name(rawValue: "ChangeLanguage")
     static let ChangeRegion = Notification.Name(rawValue: "ChangeRegion")
     static let OpenPlayBar = Notification.Name(rawValue: "OpenPlayBar")
}

extension String {
    
    func verifyUrl() -> Bool {
        if let url = URL(string: self) {
            return UIApplication.shared.canOpenURL(url)
        }
        return false
    }
    
    func replacingOccurrences() -> String {
        return self.replacingOccurrences(of: " ", with: "+")
    }
    
    func isUrlFile() -> Bool {
        if self.hasSuffix(".pdf") || self.hasSuffix(".doc")  || self.hasSuffix(".docx") ||
           self.hasSuffix(".xls") || self.hasSuffix(".xlsx") || self.hasSuffix(".zip") ||
           self.hasSuffix(".ppt") || self.hasSuffix(".pttx") || self.hasSuffix(".mp3") ||
           self.hasSuffix(".wav") || self.hasSuffix(".rtf")  || self.hasSuffix(".png") ||
           self.hasSuffix(".jpg") || self.hasSuffix(".gif")  || self.hasSuffix(".mp4") {
            return true
        }
        return false
    }
    
    var localizeLanguage: String {
        return NSLocalizedString(self, comment: "")
    }
    
    //validate email
    func isValidEmail()-> Bool{
        if self.count > 254 {
            return false
        }
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        
        let email = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return email.evaluate(with: self)
    }
    
    //validate phone number
    var isPhoneNumber: Bool {
        do {
            let detector = try NSDataDetector(types: NSTextCheckingResult.CheckingType.phoneNumber.rawValue)
            let matches = detector.matches(in: self, options: [], range: NSMakeRange(0, self.count))
            if let res = matches.first {
                return res.resultType == .phoneNumber && res.range.location == 0 && res.range.length == self.count && self.count == 10
            } else {
                return false
            }
        } catch {
            return false
        }
    }
    
    func isEmptyOrWhitespace() -> Bool {
        if(self.isEmpty) {
            return true
        }
        return (self.trimmingCharacters(in: CharacterSet.whitespaces) == "")
    }
    
    func toDateTime(_ dateFormat: String = "dd.MM.yyyy HH:mm:ss") -> Date {
        //Create Date Formatter
        let dateFormatter = DateFormatter()
        
        //Specify Format of String to Parse
        dateFormatter.dateFormat = dateFormat
        //Parse into NSDate
        let dateFromString : Date? = dateFormatter.date(from: self)
        
        //Return Parsed Date
        return dateFromString!
    }
}

extension UIApplication {
    
    static var rootVC: UINavigationController? {
        return UIApplication.shared.keyWindow?.rootViewController as? UINavigationController
    }
    
    class func topViewController(controller: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let navigationController = controller as? UINavigationController {
            return topViewController(controller: navigationController.visibleViewController)
        }
        
        if let tabController = controller as? UITabBarController {
            if let selected = tabController.selectedViewController {
                return topViewController(controller: selected)
            }
        }
        
        if let presented = controller?.presentedViewController {
            return topViewController(controller: presented)
        }
        
        return controller
    }
}

