//
//  JY_City_Selection_Current_City_Header_Cell+Assets.swift
//  JYYQCustomController
//
//  Created by JYYQLin on 2025/4/15.
//

import UIKit

extension JY_City_Selection_Current_City_Header_Cell {

    public static func yq_title_textColor() -> UIColor {
        return UIColor(named: "JY_City_Selection_Current_City_Header_Cell_title_textColor") ?? UIColor.yq_color(colorString: "#9E9E9E")
    }
    
    public static func yq_repositioning_icon() -> String {
        return "JY_City_Selection_Current_City_Header_Cell_repositioning_icon"
    }
    
    public static func yq_repositioning_button_bgColor() -> UIColor {
        return UIColor(named: "JY_City_Selection_Current_City_Header_Cell_repositioning_button_bgColor") ?? UIColor.yq_color(colorString: "#FDFDFD")
    }
}
