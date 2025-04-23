//
//  SC_Base_Controller.swift
//  JYYQCustomController
//
//  Created by JYYQLin on 2025/4/22.
//

import UIKit
import JY_Toolbox

class SC_Base_Controller: JY_Base_Controller {

    private lazy var yq_loading_view: JY_Shimmer_Loading_View = JY_Shimmer_Loading_View()
}

extension SC_Base_Controller {
    
    override func yq_setInterface() {
        super.yq_setInterface()
        
        yq_request_loading_addSubview(yq_loading_view)
    }
    
    override func yq_setSubviewsFrame() {
        super.yq_setSubviewsFrame()
        
        yq_background_content_view.backgroundColor = yq_controller_bgColor()
        
        yq_loading_view.frame.origin = {
            yq_loading_view.frame.size = CGSize(width: 79 * yq_scale, height: 79 * yq_scale)
            yq_loading_view.yq_set(scale: yq_scale)
            
            return CGPoint(x: (view.frame.width - yq_loading_view.frame.width) * 0.5, y: (view.frame.height - yq_loading_view.frame.height) * 0.5 - yq_loading_view.frame.height * 0.25)
        }()
    }
}
