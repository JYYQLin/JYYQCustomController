//
//  JY_City_Selection_Controller.swift
//  JYYQCustomController
//
//  Created by JYYQLin on 2025/4/15.
//

import UIKit
import JY_Toolbox

class JY_City_Selection_Controller: JY_Base_Controller {
    
    private lazy var yq_navigationBar: JY_City_Selection_NavigationBar = {
        let view = JY_City_Selection_NavigationBar()
        
        view.yq_add_back_button_target(self, action: #selector(yq_back_click), for: .touchUpInside)
        
        return view
    }()
    
    private lazy var yq_position_view: JY_City_Selection_View = {
        let view = JY_City_Selection_View()
        
        view.yq_repositioning_click_block = { [weak self] in
            self?.yq_repositioning_click()
        }
        
        view.yq_city_click_block = { [weak self] city in
//            self?.yq_city_click(city: city)
        }
        
        view.yq_keyboard_height_change_block = { [weak self] height in
//            self?.yq_search_detail_controller?.yq_keyboard_height = height
        }
        
        return view
    }()
}

extension JY_City_Selection_Controller {
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
}

extension JY_City_Selection_Controller {
    
    override func yq_setNavigationBar() {
        super.yq_setNavigationBar()
        
        view.addSubview(yq_navigationBar)
    }
    
    override func yq_setInterface() {
        super.yq_setInterface()
        
        yq_content_view.addSubview(yq_position_view)
    }
    
    override func yq_setSubviewsFrame() {
        super.yq_setSubviewsFrame()
        
        yq_navigationBar.frame.origin = {
            
            let height = (yq_is_push == true ? yq_current_device.yq_navigationBar_maxY() : yq_current_device.yq_navigationBar_height()) + yq_navigationBar.yq_city_searchBar_height
            
            yq_navigationBar.frame.size = CGSize(width: view.frame.width, height: height)
            
            yq_navigationBar.yq_hidden_back_button = !(yq_is_push == true || navigationController != nil)
            
            return CGPoint.zero
        }()
        
        yq_position_view.frame.origin = {
            yq_position_view.frame.size = CGSize(width: yq_content_view.frame.width, height: yq_content_view.frame.height - yq_navigationBar.frame.maxY)
            yq_position_view.yq_set(scale: yq_scale)
            return CGPoint(x: 0, y: yq_navigationBar.frame.maxY)
        }()
    }
}

extension JY_City_Selection_Controller {
    static func yq_show(_ fromController: UIViewController, isPush: Bool = true) {
        let controller = JY_City_Selection_Controller()
        
        let navigationController = fromController.navigationController
        
        if isPush == true && navigationController != nil {
            controller.yq_is_push = true
            navigationController?.pushViewController(controller, animated: true)
        }else{
            controller.yq_is_push = false
            fromController.present(controller, animated: true)
        }
    }
}
