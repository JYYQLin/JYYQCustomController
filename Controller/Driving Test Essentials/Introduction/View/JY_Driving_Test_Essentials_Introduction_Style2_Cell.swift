//
//  JY_Driving_Test_Essentials_Introduction_Style2_Cell.swift
//  JYYQCustomController
//
//  Created by JYYQLin on 2025/4/22.
//

import UIKit
import JY_Toolbox

class JY_Driving_Test_Essentials_Introduction_Style2_Cell: JY_Base_CollectionViewCell {

    lazy var yq_imageName: String = "" {
        didSet {
            if yq_imageName.count > 0 {
                yq_imageView.yq_imageName = yq_imageName
            }
        }
    }
    
    private lazy var yq_imageView: JY_ImageView = JY_ImageView()

}

extension JY_Driving_Test_Essentials_Introduction_Style2_Cell {
    override func yq_add_subviews() {
        super.yq_add_subviews()
        
        contentView.addSubview(yq_imageView)
    }
    
}

extension JY_Driving_Test_Essentials_Introduction_Style2_Cell {
    override func layoutSubviews() {
        super.layoutSubviews()
        
        yq_imageView.frame = contentView.bounds
        yq_imageView.contentMode = .scaleAspectFit
    }
}
