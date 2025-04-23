//
//  JY_Driving_Test_Essentials_Video_List_Controller.swift
//  JY_Project_Library
//
//  Created by JYYQLin on 2025/4/23.
//

import UIKit
import JY_Toolbox

class JY_Driving_Test_Essentials_Video_List_Controller: SC_Base_Controller {

    private lazy var yq_detail_view: JY_Driving_Test_Essentials_Video_List_View = {
        let view = JY_Driving_Test_Essentials_Video_List_View()
        
        view.yq_current_selected_index_change_block = { [weak self] (index, videoArray) in
            self?.yq_play_video(video: videoArray[index])
        }
        
        return view
    }()
}

extension JY_Driving_Test_Essentials_Video_List_Controller {
    private func yq_play_video(video: JY_Driving_Test_Essentials_Video_View_Model) {
        print("video = " + video.yq_video_url)
    }
}

extension JY_Driving_Test_Essentials_Video_List_Controller {
    
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

extension JY_Driving_Test_Essentials_Video_List_Controller {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        yq_retry_request_click()
    }
}

extension JY_Driving_Test_Essentials_Video_List_Controller {
    override func yq_retry_request_click() {
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
        
        var videoArary = [JY_Driving_Test_Essentials_Video_View_Model]()
        for (index, dic) in titleDicArray.enumerated() {
            let viewModel = JY_Driving_Test_Essentials_Video_View_Model()
            viewModel.yq_set(ID: dic["ID"] as? String ?? "", title: dic["title"] as? String ?? "", duration: 30 + 20 * index, videoUrl: "", isUnlock: ((index) % 3 == 0), dic: [String : Any]())
            
            videoArary.append(viewModel)
        }
        
        yq_detail_view.yq_set(videoArray: videoArary)
    }
}
