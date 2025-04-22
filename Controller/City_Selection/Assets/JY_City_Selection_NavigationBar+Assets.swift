//
//  JY_City_Selection_NavigationBar+Assets.swift
//  JYYQCustomController
//
//  Created by JYYQLin on 2025/4/15.
//

import UIKit
import JY_Toolbox

extension JY_City_Selection_NavigationBar {
    
    public static func yq_navigationBar_bgColor() -> UIColor {
        return UIColor(named: "JY_City_Selection_NavigationBar_bgColor") ?? UIColor.yq_color(colorString: "#FDFDFD")
    }

    public static func yq_navigationBar_title_textColor() -> UIColor {
        return UIColor(named: "JY_City_Selection_NavigationBar_title_textColor") ?? UIColor.yq_color(colorString: "#212121")
    }
}
