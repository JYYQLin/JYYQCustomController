//
//  JY_Navigation_Controller+Assets.swift
//  JYYQCustomController
//
//  Created by JYYQLin on 2025/4/15.
//

import UIKit

extension JY_Navigation_Controller {
    static func yq_normal_back_imageName() -> String {
        return "yq_icon_back_black"
    }
    
    static func yq_night_back_imageName() -> String {
        return "yq_icon_back_night"
    }
    
    static func yq_white_back_imageName() -> String {
        return "yq_icon_back_white"
    }
    
    static func yq_title_font() -> UIFont {
        return UIFont.systemFont(ofSize: 16)
    }
    
    static func yq_title_textColor() -> UIColor {
        return UIColor(red: 33 / 255.0, green: 33 / 255.0, blue: 33 / 255.0, alpha: 1)
    }
    
    static func yq_title_light_textColor() -> UIColor {
        return UIColor(red: 249 / 255.0, green: 243 / 255.0, blue: 247 / 255.0, alpha: 0.95)
    }
}
