//
//  JY_City_Selection_Current_City_Header_Cell.swift
//  JYYQCustomController
//
//  Created by JYYQLin on 2025/4/15.
//

import UIKit
import JY_Toolbox

class JY_City_Selection_Current_City_Header_Cell: JY_Base_CollectionViewCell {
    
    private lazy var yq_title_label: UILabel = UILabel()
    private lazy var yq_repositioning_button: UIButton = UIButton()
    private lazy var yq_repositioning_label: UILabel = UILabel()
    private lazy var yq_repositioning_imageView: JY_ImageView = JY_ImageView()
    
}

extension JY_City_Selection_Current_City_Header_Cell {
    override func yq_add_subviews() {
        super.yq_add_subviews()
        
        contentView.addSubview(yq_title_label)
        contentView.addSubview(yq_repositioning_button)
        contentView.addSubview(yq_repositioning_label)
        contentView.addSubview(yq_repositioning_imageView)
    }
}

extension JY_City_Selection_Current_City_Header_Cell {
    func yq_set(title: String, scale: CGFloat) {
        yq_title_label.text = title
        yq_set(scale: scale)
    }
}

extension JY_City_Selection_Current_City_Header_Cell {
    func yq_add_repositioning_button_target(_ target: Any?, action: Selector, for controlEvents: UIControl.Event) {
        yq_repositioning_button.addTarget(target, action: action, for: controlEvents)
    }
}

extension JY_City_Selection_Current_City_Header_Cell {
    override func layoutSubviews() {
        super.layoutSubviews()
        
        yq_title_label.frame.origin = {
            yq_title_label.font = UIFont.yq_medium_font(12 * yq_scale)
            yq_title_label.textColor = JY_City_Selection_Current_City_Header_Cell.yq_title_textColor()
            yq_title_label.sizeToFit()
            return CGPoint(x: 15 * yq_scale, y: (contentView.frame.height - yq_title_label.frame.height) * 0.5)
        }()
        
        yq_repositioning_label.frame.origin = {
            yq_repositioning_label.text = "重新定位".yq_localized(tableName: "JY_Position")
            yq_repositioning_label.textColor = JY_City_Selection_Current_City_Header_Cell.yq_title_textColor()
            yq_repositioning_label.font = UIFont.yq_medium_font(12 * yq_scale)
            yq_repositioning_label.sizeToFit()
            return CGPoint(x: contentView.frame.width - 25 * yq_scale - yq_repositioning_label.frame.width, y: (contentView.frame.height - yq_repositioning_label.frame.height) * 0.5)
        }()
        
        yq_repositioning_imageView.frame.origin = {
            yq_repositioning_imageView.frame.size = CGSize(width: 12 * yq_scale, height: 12 * yq_scale)
            yq_repositioning_imageView.yq_imageName = JY_City_Selection_Current_City_Header_Cell.yq_repositioning_icon()
            return CGPoint(x: yq_repositioning_label.frame.minX - yq_repositioning_imageView.frame.width - 2 * yq_scale, y: yq_repositioning_label.frame.midY - yq_repositioning_imageView.frame.height * 0.5)
        }()
        
        yq_repositioning_button.frame.origin = {
            yq_repositioning_button.frame.size = CGSize(width: (yq_repositioning_label.frame.maxX - yq_repositioning_imageView.frame.minX) + 10 * yq_scale * 2, height: 26 * yq_scale)
            
            let bgImage = UIImage.yq_generate_image(color: JY_City_Selection_Current_City_Header_Cell.yq_repositioning_button_bgColor(), imageSize: yq_repositioning_button.frame.size, cornerRadius: yq_repositioning_button.frame.height * 0.5)
            
            yq_repositioning_button.setBackgroundImage(bgImage, for: .normal)
            
            return CGPoint(x: yq_repositioning_imageView.frame.minX - 10 * yq_scale, y: yq_repositioning_label.frame.midY - yq_repositioning_button.frame.height * 0.5)
        }()
    }
}
