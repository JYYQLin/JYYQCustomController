//
//  SC_Driving_Test_Essentials_Introduction_Controller.swift
//  JYYQCustomController
//
//  Created by JYYQLin on 2025/4/22.
//

import UIKit

class SC_Driving_Test_Essentials_Introduction_Controller: SC_Base_Controller {
    
    private lazy var yq_detail_view: SC_Driving_Test_Essentials_Introduction_View = SC_Driving_Test_Essentials_Introduction_View()
}

extension SC_Driving_Test_Essentials_Introduction_Controller {
    
    override func yq_setInterface() {
        super.yq_setInterface()
        
        yq_content_view.addSubview(yq_detail_view)
    }
    
    override func yq_setSubviewsFrame() {
        super.yq_setSubviewsFrame()
        
        yq_detail_view.frame.origin = {
            yq_detail_view.frame.size = yq_content_view.bounds.size
            yq_detail_view.yq_set(scale: yq_scale)
            return yq_content_view.bounds.origin
        }()
        
    }
}
