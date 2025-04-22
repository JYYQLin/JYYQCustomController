//
//  SC_Driving_Test_Essentials_NavigationBar.swift
//  JYYQCustomController
//
//  Created by JYYQLin on 2025/4/22.
//

import UIKit
import JY_Toolbox

class SC_Driving_Test_Essentials_NavigationBar: JY_View {

    private lazy var yq_title_imageView: JY_ImageView = JY_ImageView()

}

extension SC_Driving_Test_Essentials_NavigationBar {
    override func yq_add_subviews() {
        super.yq_add_subviews()
        
        addSubview(yq_title_imageView)
    }
}

extension SC_Driving_Test_Essentials_NavigationBar {
    override func layoutSubviews() {
        super.layoutSubviews()
        
        yq_title_imageView_frame()
    }
    
    private func yq_title_imageView_frame() {
        yq_title_imageView.frame.origin = {
            yq_title_imageView.frame.size = CGSize(width: 141 * yq_scale, height: 18 * yq_scale)
            yq_title_imageView.yq_imageName = "79cad0aea072ec0fe43ab70ac5e1880b"
            return CGPoint(x: (frame.width - yq_title_imageView.frame.width) * 0.5, y: (frame.height - yq_title_imageView.frame.height) * 0.5)
        }()
    }
}
