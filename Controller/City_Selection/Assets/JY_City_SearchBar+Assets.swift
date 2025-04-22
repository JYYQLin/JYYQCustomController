//
//  JY_City_SearchBar+Assets.swift
//  JYYQCustomController
//
//  Created by JYYQLin on 2025/4/15.
//

import UIKit
import JY_Toolbox

extension JY_City_SearchBar {

    public static func yq_bgColor() -> UIColor {
        return UIColor(named: "JY_City_SearchBar_bgColor") ?? UIColor.yq_color(colorString: "#F8F8F8")
    }
    
    public static func yq_search_icon() -> String {
        return "JY_City_SearchBar_search_icon"
    }
    
    public static func yq_textField_placeholder_color() -> UIColor {
        return UIColor(named: "JY_City_SearchBar_textField_placeholder_color") ?? UIColor.yq_color(colorString: "#BDBDBD")
    }
    
    public static func yq_textField_textColor() -> UIColor {
        return UIColor(named: "JY_City_SearchBar_textField_textColor") ?? UIColor.yq_color(colorString: "#424242")
    }
}
