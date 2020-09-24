//
//  AppConstant.swift
//  BrowserApp
//
//  Created by admin on 25/11/2019.
//  Copyright © 2019 nxsang063@gmail.com. All rights reserved.
//

import Foundation
import UIKit

let api_key =  "AIzaSyDT6DczdeKqckkp8qxDXNxo02Uw1jL4Je4"//"AIzaSyBw6nKP38wy-GtLEMPxKRfSGLrCWcf88gk"

struct AppConstant {
    
    static let SCREEN_SIZE: CGRect = UIScreen.main.bounds
    static let SREEEN_WIDTH = SCREEN_SIZE.width
    static let SCREEN_HEIGHT = SCREEN_SIZE.height
    static let STATUS_BAR_BOTTOM = SCREEN_HEIGHT >= 812 || SREEEN_WIDTH >= 812 ? CGFloat(44) : CGFloat(28)
    static let STATUS_BAR_TOP = SCREEN_HEIGHT >= 812 ? CGFloat(44) : CGFloat(20)
    static let TOOL_BAR_HEIGHT = CGFloat(44)
    static let NAVI_BAR_HEIGHT = CGFloat(44)
    
    static let HEIGTH_TABBAR: CGFloat = 30 + STATUS_BAR_BOTTOM
}

let kEmpty                  = ""
let kOK                     = "OK"


//Mark: Firebase KEY
let ID                      = "id"
let USER                    = "Users"
let NAME                    = "name"
let EMAIL                   = "email"

