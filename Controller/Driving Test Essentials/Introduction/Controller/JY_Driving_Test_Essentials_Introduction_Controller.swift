//
//  JY_Driving_Test_Essentials_Introduction_Controller.swift
//  JYYQCustomController
//
//  Created by JYYQLin on 2025/4/22.
//

import UIKit

open class JY_Driving_Test_Essentials_Introduction_Controller: SC_Base_Controller {
    
    private lazy var yq_detail_view: JY_Driving_Test_Essentials_Introduction_View = JY_Driving_Test_Essentials_Introduction_View()
}

extension JY_Driving_Test_Essentials_Introduction_Controller {
    
    open override func yq_setInterface() {
        super.yq_setInterface()
        
        yq_content_view.addSubview(yq_detail_view)
    }
    
    open override func yq_setSubviewsFrame() {
        super.yq_setSubviewsFrame()
        
        yq_detail_view.frame.origin = {
            yq_detail_view.frame.size = yq_content_view.bounds.size
            yq_detail_view.yq_set(scale: yq_scale)
            return yq_content_view.bounds.origin
        }()
        
    }
}
