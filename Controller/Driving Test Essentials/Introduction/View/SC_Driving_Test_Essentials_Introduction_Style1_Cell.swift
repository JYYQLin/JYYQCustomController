//
//  JY_Driving_Test_Essentials_Introduction_Style1_Cell.swift
//  JYYQCustomController
//
//  Created by JYYQLin on 2025/4/22.
//

import UIKit
import JY_Toolbox

class JY_Driving_Test_Essentials_Introduction_Style1_Cell: JY_Base_CollectionViewCell {

    private lazy var yq_left_imageView: JY_ImageView = JY_ImageView()
    private lazy var yq_center_imageView: JY_ImageView = JY_ImageView()
    private lazy var yq_right_imageView: JY_ImageView = JY_ImageView()
    
}

extension JY_Driving_Test_Essentials_Introduction_Style1_Cell {
    override func yq_add_subviews() {
        super.yq_add_subviews()
        
        contentView.addSubview(yq_left_imageView)
        contentView.addSubview(yq_center_imageView)
        contentView.addSubview(yq_right_imageView)
    }
}

extension JY_Driving_Test_Essentials_Introduction_Style1_Cell {
    override func layoutSubviews() {
        super.layoutSubviews()
        
        yq_center_imageView.frame.origin = {
            yq_center_imageView.yq_imageName = "9f6d6532974e49bd8b4f992ab1317162"
            yq_center_imageView.frame.size = CGSize(width: contentView.frame.height * (100.0 / 93.0), height: contentView.frame.height)
            return CGPoint(x: (contentView.frame.width - yq_center_imageView.frame.width) * 0.5, y: (contentView.frame.height - yq_center_imageView.frame.height) * 0.5)
        }()
        
        yq_left_imageView.frame.origin = {
            yq_left_imageView.frame.size = yq_center_imageView.frame.size
            yq_left_imageView.yq_imageName = "dd08a7243933adb71c15306f2b901092"
            return CGPoint(x: yq_center_imageView.frame.minX - yq_left_imageView.frame.width - 15 * yq_scale, y: (contentView.frame.height - yq_left_imageView.frame.height) * 0.5)
        }()
        
        yq_right_imageView.frame.origin = {
            yq_right_imageView.yq_imageName = "3a16142eae40eb571ccccae567e43739"
            yq_right_imageView.frame.size = yq_center_imageView.frame.size
            return CGPoint(x: yq_center_imageView.frame.maxX + 15 * yq_scale, y: (contentView.frame.height - yq_right_imageView.frame.height) * 0.5)
        }()
    }
}
