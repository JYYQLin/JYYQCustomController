//
//  JY_City_Selection_All_City_Cell.swift
//  JYYQCustomController
//
//  Created by JYYQLin on 2025/4/15.
//

import UIKit
import JYYQToolBox

class JY_City_Selection_All_City_Cell: JY_Base_CollectionViewCell {
    
    private lazy var yq_city: JY_City = JY_City()
    
    private lazy var yq_title_label: UILabel = UILabel()
    private lazy var yq_under_line_view: UIView = UIView()
}

extension JY_City_Selection_All_City_Cell {
    override func yq_add_subviews() {
        super.yq_add_subviews()
        
        contentView.addSubview(yq_title_label)
        contentView.addSubview(yq_under_line_view)
    }
}

extension JY_City_Selection_All_City_Cell {
    func yq_set(city: JY_City, scale: CGFloat, hiddenUnderLine: Bool) {
        yq_title_label.text = city.yq_full_name
        yq_under_line_view.isHidden = hiddenUnderLine
        yq_scale = scale
    }
}

extension JY_City_Selection_All_City_Cell {
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.backgroundColor = JY_City_Selection_All_City_Cell.yq_bgColor()
        
        yq_title_label.frame.origin = {
            yq_title_label.textColor = JY_City_Selection_All_City_Cell.yq_title_textColor()
            yq_title_label.font = UIFont.systemFont(ofSize: 13 * yq_scale)
            yq_title_label.sizeToFit()
            return CGPoint(x: 15 * yq_scale, y: (contentView.frame.height - yq_title_label.frame.height) * 0.5)
        }()
        
        yq_under_line_view.frame.origin = {
            yq_under_line_view.frame.size = CGSize(width: contentView.frame.width - yq_title_label.frame.minX * 2, height: 1 * yq_scale)
            yq_under_line_view.backgroundColor = JY_City_Selection_All_City_Cell.yq_underLine_color()
            return CGPoint(x: yq_title_label.frame.minX, y: contentView.frame.height - yq_under_line_view.frame.height)
        }()
    }
}
