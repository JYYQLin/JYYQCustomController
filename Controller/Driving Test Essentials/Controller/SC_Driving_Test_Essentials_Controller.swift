//
//  SC_Driving_Test_Essentials_Controller.swift
//  JYYQCustomController
//
//  Created by JYYQCustomController on 2025/4/22.
//

import UIKit
import JY_Toolbox

class SC_Driving_Test_Essentials_Controller: SC_Base_Controller {

    lazy var yq_navigationBar: SC_Driving_Test_Essentials_NavigationBar = SC_Driving_Test_Essentials_NavigationBar()
    
    lazy var yq_video_view: SC_Driving_Test_Essentials_Video_View = SC_Driving_Test_Essentials_Video_View()
    
    lazy var yq_segment_view: SC_Driving_Test_Essentials_Segment_View = {
        let view = SC_Driving_Test_Essentials_Segment_View()
        
        view.yq_title_click_block = { [weak self] index in
            self?.yq_page_controller.yq_set(pageIndex: index)
        }
        
        return view
    }()
    
    lazy var yq_page_controller: SC_Driving_Test_Essentials_PageController = {
        let controller = SC_Driving_Test_Essentials_PageController()
        
        controller.yq_page_index_block = { [weak self] in
            self?.yq_segment_view.yq_set(scrollProgress: Float(controller.yq_current_page_index))
        }
        
        return controller
    }()
}

extension SC_Driving_Test_Essentials_Controller {
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
}

extension SC_Driving_Test_Essentials_Controller {
    override func yq_setNavigationBar() {
        super.yq_setNavigationBar()
        
        view.addSubview(yq_navigationBar)
        view.addSubview(yq_video_view)
    }
    
    override func yq_setInterface() {
        super.yq_setInterface()
        
        yq_content_view.addSubview(yq_segment_view)
        
        addChild(yq_page_controller)
        yq_content_view.addSubview(yq_page_controller.view)
    }
    
    override func yq_setSubviewsFrame() {
        super.yq_setSubviewsFrame()
        
        yq_background_content_view.backgroundColor = UIColor.yq_color(colorString: "#010101")
        
        yq_navigationBar.frame.origin = {
            let scale = 1.0
            yq_navigationBar.frame.size = CGSize(width: view.frame.width, height: 28 * scale)
            yq_navigationBar.yq_set(scale: scale)
            return CGPoint(x: 0, y: yq_current_device.yq_statusBar_height())
        }()
        
        yq_video_view.frame.origin = {
            yq_video_view.frame.size = CGSize(width: view.frame.width, height: 211 * yq_scale)
            yq_video_view.yq_set(scale: yq_scale)
            return CGPoint(x: 0, y: yq_navigationBar.frame.maxY)
        }()
        
        yq_segment_view.frame.origin = {
            yq_segment_view.frame.size = CGSize(width: yq_content_view.frame.width, height: 45 * yq_scale)
            yq_segment_view.yq_set(scale: yq_scale)
            yq_segment_view.backgroundColor = UIColor.yq_color(colorString: "FDFEFD")
            return CGPoint(x: 0, y: yq_video_view.frame.maxY)
        }()
        
        yq_page_controller.view.frame.origin = {
            yq_page_controller.view.frame.size = CGSize(width: yq_content_view.frame.width, height: yq_content_view.frame.height - yq_segment_view.frame.maxY)
            yq_page_controller.view.backgroundColor = yq_segment_view.backgroundColor
            return CGPoint(x: 0, y: yq_content_view.frame.height - yq_page_controller.view.frame.height)
        }()
    }
}
