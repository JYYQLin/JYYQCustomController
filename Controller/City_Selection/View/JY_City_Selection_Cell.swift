//
//  JY_City_Selection_Cell.swift
//  JYYQCustomController
//
//  Created by JYYQLin on 2025/4/15.
//

import UIKit
import JY_Toolbox

class JY_City_Selection_Cell: JY_Base_CollectionViewCell {
    
    private lazy var yq_city: JY_City = JY_City()
    
    private lazy var yq_title_label: UILabel = UILabel()
}

extension JY_City_Selection_Cell {
    override func yq_add_subviews() {
        super.yq_add_subviews()
        
        contentView.addSubview(yq_title_label)
    }
}

extension JY_City_Selection_Cell {
    func yq_set(city: JY_City?, scale: CGFloat) {
        yq_title_label.text = city?.yq_full_name
       yq_set(scale: scale)
    }
}

extension JY_City_Selection_Cell {
    func yq_size(city: JY_City?, scale: CGFloat) -> CGSize {
        
        if city == nil {
            return CGSize(width: 100 * yq_scale, height: 22 * scale)
        }
        else{
            yq_title_label.text = city?.yq_full_name
            yq_set(scale: scale)
            
            return yq_title_label.frame.size
        }
    }
}

extension JY_City_Selection_Cell {
    override func layoutSubviews() {
        super.layoutSubviews()
        
        yq_title_label.frame.origin = {
            yq_title_label.textColor = JY_City_Selection_Cell.yq_title_textColor()
            yq_title_label.font = UIFont.systemFont(ofSize: 13 * yq_scale)
            yq_title_label.sizeToFit()
            return CGPoint(x: 25 * yq_scale, y: (contentView.frame.height - yq_title_label.frame.height) * 0.5)
        }()
    }
}
