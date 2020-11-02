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

//Mark: APP STRING
let kEmpty                  = ""
let kOK                     = "OK"
let kWarning                = "Lưu ý"
let kLogoutMessage          = "Bạn có muốn đăng xuất không."
let kAccept                 = "Đồng ý"
let kClose                  = "Đóng"

//Mark: FIREBASE KEY
let ID                      = "id"
let USER                    = "Users"
let NAME                    = "name"
let EMAIL                   = "email"

//NOTIFICATION KEY
let KNET_STATUS             = "K_NET_STATUS"

//ALL TOPIC

struct Topic {
    var title: String!
    var image: String!
    var fileName: String!
    var type: String!
}

let topics = [Topic(title: "Ielts Part-1", image: "ielts", fileName: "ielts1", type: "ielts1"),
              Topic(title: "Ielts Part-2", image: "ielts", fileName: "ielts2", type: "ielts2"),
              Topic(title: "Ielts Part-3", image: "ielts", fileName: "ielts3", type: "ielts3"),
              Topic(title: "Ielts Part-4", image: "ielts", fileName: "ielts4", type: "ielts4"),
              Topic(title: "Ielts Part-5", image: "ielts", fileName: "ielts5", type: "ielts5"),
              Topic(title: "Ielts Part-6", image: "ielts", fileName: "ielts6", type: "ielts6"),
              Topic(title: "Ielts Part-7", image: "ielts", fileName: "ielts7", type: "ielts7"),
              Topic(title: "Ielts Part-8", image: "ielts", fileName: "ielts8", type: "ielts8"),
              Topic(title: "Ielts Part-9", image: "ielts", fileName: "ielts9", type: "ielts9")
]
