//
//  JY_City_Selection_Hot_City_Cell.swift
//  JYYQCustomController
//
//  Created by JYYQLin on 2025/4/15.
//

import UIKit
import JY_Toolbox

class JY_City_Selection_Hot_City_Cell: JY_Base_CollectionViewCell {
    
    private lazy var yq_city: JY_City = JY_City()
    
    private lazy var yq_title_label: UILabel = UILabel()
    
    override func yq_add_subviews() {
        super.yq_add_subviews()
        
        contentView.addSubview(yq_title_label)
    }
}

extension JY_City_Selection_Hot_City_Cell {
    func yq_set(city: JY_City, scale: CGFloat) {
        yq_title_label.text = city.yq_abbreviation_name
        yq_set(scale: scale)
    }
}

extension JY_City_Selection_Hot_City_Cell {
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.backgroundColor = JY_City_Selection_Hot_City_Cell.yq_bgColor()
        
        yq_title_label.frame.origin = {
            yq_title_label.textColor = JY_City_Selection_Hot_City_Cell.yq_title_textColor()
            yq_title_label.font = UIFont.systemFont(ofSize: 15 * yq_scale)
            yq_title_label.textAlignment = .center
            yq_title_label.sizeToFit()
            return CGPoint(x: (contentView.frame.width - yq_title_label.frame.width) * 0.5, y: (contentView.frame.height - yq_title_label.frame.height) * 0.5)
        }()
    }
}
