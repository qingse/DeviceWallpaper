//
//  UserAgent.swift
//  DeviceWallpaper
//
//  Created by Kensuke Hoshikawa on 2017/04/22.
//  Copyright © 2017年 star__hoshi. All rights reserved.
//

import Foundation
import UIKit.UIWebView

struct UserAgent {
    var value: String

    init() {
        value = UIWebView().userAgent
    }
}
