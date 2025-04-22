//
//  JY_City_Selection_All_City_Header_Cell.swift
//  JYYQCustomController
//
//  Created by JYYQLin on 2025/4/15.
//

import UIKit
import JY_Toolbox

class JY_City_Selection_All_City_Header_Cell: JY_Base_CollectionViewCell {
    
    private lazy var yq_title_label: UILabel = UILabel()
    
    private lazy var yq_title_label_x: CGFloat = 15
}

extension JY_City_Selection_All_City_Header_Cell {
    override func yq_add_subviews() {
        super.yq_add_subviews()
        
        contentView.addSubview(yq_title_label)
    }
}

extension JY_City_Selection_All_City_Header_Cell {
    func yq_set(title: String, scale: CGFloat, x: CGFloat = 15) {
        yq_title_label.text = title
        yq_title_label_x = x
        
        layoutSubviews()
    }
}

extension JY_City_Selection_All_City_Header_Cell {
    override func layoutSubviews() {
        super.layoutSubviews()
        
        yq_title_label.frame.origin = {
            yq_title_label.font = UIFont.yq_medium_font(12 * yq_scale)
            yq_title_label.textColor = JY_City_Selection_All_City_Header_Cell.yq_title_textColor()
            yq_title_label.sizeToFit()
            return CGPoint(x: yq_title_label_x * yq_scale, y: (contentView.frame.height - yq_title_label.frame.height) * 0.5)
        }()
    }
}
