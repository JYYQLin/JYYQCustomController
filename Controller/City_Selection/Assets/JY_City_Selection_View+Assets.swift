//
//  JY_City_Selection_View+Assets.swift
//  JYYQCustomController
//
//  Created by JYYQLin on 2025/4/15.
//

import UIKit

extension JY_City_Selection_View {
    
    public static func yq_bgColor() -> UIColor {
        return UIColor(named: "JY_City_Selection_View_bgColor") ?? UIColor.yq_color(colorString: "#3D3D3D").withAlphaComponent(0.75)
    }

    public static func yq_title_textColor() -> UIColor {
        return UIColor(named: "JY_City_Selection_View_title_textColor") ?? UIColor.yq_color(colorString: "#FAFAFA")
    }
}
