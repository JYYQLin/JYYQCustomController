//
//  JY_City_Selection_Controller+Interaction_Methods.swift
//  JYYQCustomController
//
//  Created by JYYQLin on 2025/4/15.
//

import UIKit

extension JY_City_Selection_Controller {
    @objc func yq_back_click() {
        if yq_is_push == true || navigationController != nil {
            navigationController?.popViewController(animated: true)
        }
        else{
            self.dismiss(animated: true)
        }
    }
    
    func yq_repositioning_click() {
        self.view.endEditing(true)
        
        yq_request_postion_city_url()
        JY_HUD_Tool.pio_show_loading()
    }
}
