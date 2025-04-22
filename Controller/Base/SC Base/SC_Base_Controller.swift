//
//  SC_Base_Controller.swift
//  JYYQCustomController
//
//  Created by JYYQLin on 2025/4/22.
//

import UIKit
import JY_Toolbox

class SC_Base_Controller: JY_Base_Controller {


}

extension SC_Base_Controller {
    override func yq_setSubviewsFrame() {
        super.yq_setSubviewsFrame()
        
        yq_background_content_view.backgroundColor = yq_controller_bgColor()
    }
}
