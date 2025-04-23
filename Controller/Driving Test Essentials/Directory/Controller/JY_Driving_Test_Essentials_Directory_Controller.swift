//
//  JY_Driving_Test_Essentials_Directory_Controller.swift
//  JYYQCustomController
//
//  Created by JYYQLin on 2025/4/22.
//

import UIKit

open class JY_Driving_Test_Essentials_Directory_Controller: SC_Base_Controller {
    
    private lazy var yq_title_view: JY_Driving_Test_Essentials_Directory_Title_Content_View = {
        let view = JY_Driving_Test_Essentials_Directory_Title_Content_View()
        
        view.yq_current_selected_index_change_block = { [weak self] (index, titleArray) in
            self?.yq_page_controller.yq_set(pageIndex: index)
        }
        
        return view
    }()
    
    private lazy var yq_page_controller: JY_Driving_Test_Essentials_Directory_PageController = {
        let controller = JY_Driving_Test_Essentials_Directory_PageController()
        
        controller.yq_page_index_block = { [weak self] index in
            self?.yq_title_view.yq_set(currentIndex: index)
        }
        
        return controller
    }()
}

extension JY_Driving_Test_Essentials_Directory_Controller {
    open override func viewDidLoad() {
        super.viewDidLoad()
        
        yq_retry_request_click()
    }
}

extension JY_Driving_Test_Essentials_Directory_Controller {
    open override func yq_setInterface() {
        super.yq_setInterface()
        
        yq_content_view.addSubview(yq_title_view)
        
        
        addChild(yq_page_controller)
        yq_content_view.addSubview(yq_page_controller.view)
    }
    
    open override func yq_setSubviewsFrame() {
        super.yq_setSubviewsFrame()
        
        yq_title_view.frame.origin = {
            yq_title_view.frame.size = CGSize(width: yq_content_view.frame.width, height: 48 * yq_scale)
            yq_title_view.yq_set(scale: yq_scale)
            return CGPoint.zero
        }()
        
        yq_page_controller.view.frame.origin = {
            yq_page_controller.view.frame.size = CGSize(width: yq_content_view.frame.width, height: yq_content_view.frame.height - yq_title_view.frame.maxY)
            return CGPoint(x: 0, y: yq_content_view.frame.height - yq_page_controller.view.frame.height)
        }()
    }
}

extension JY_Driving_Test_Essentials_Directory_Controller {
    open override func yq_retry_request_click() {
        super.yq_retry_request_click()
        
        yq_controller_status = .yq_data_loaded
        
        let titleDicArray: [[String: Any]] = [
            ["ID": "1", "title": "第一课"],
            ["ID": "2", "title": "第二课"],
            ["ID": "3", "title": "第三课"],
            ["ID": "1", "title": "第一课"],
            ["ID": "2", "title": "第二课"],
            ["ID": "3", "title": "第三课"],
        ]
        
        var titleViewModelArray = [JY_Driving_Test_Essentials_Directory_Title_View_Model]()
        for dic in titleDicArray {
            let viewModel = JY_Driving_Test_Essentials_Directory_Title_View_Model()
            viewModel.yq_set(ID: dic["ID"] as? String ?? "", title: dic["title"] as? String ?? "", dic: dic)
            titleViewModelArray.append(viewModel)
        }
        
        yq_title_view.yq_set(titleArray: titleViewModelArray)
        yq_page_controller.yq_set(titleArray: titleViewModelArray)
    }
}
