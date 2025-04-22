//
//  SC_Driving_Test_Essentials_Segment_View.swift
//  JYYQCustomController
//
//  Created by JYYQLin on 2025/4/22.
//

import UIKit
import JY_Toolbox

class SC_Driving_Test_Essentials_Segment_View: JY_View {
    
    var yq_title_click_block: ((_ index: Int) -> Void)?
    
    private lazy var yq_segment_view: SC_Driving_Test_Essentials_Segment_Control = {
        let view = SC_Driving_Test_Essentials_Segment_Control()
        
        view.yq_title_click_block = { [weak self] index in
            if self != nil && self?.yq_title_click_block != nil {
                self!.yq_title_click_block!(index)
            }
        }
        
        return view
    }()
}

extension SC_Driving_Test_Essentials_Segment_View {
    func yq_set(scrollProgress: Float) {
        yq_segment_view.yq_set(scrollProgress: scrollProgress)
    }
}


extension SC_Driving_Test_Essentials_Segment_View {
    override func yq_add_subviews() {
        super.yq_add_subviews()
        
        addSubview(yq_segment_view)
    }
}

extension SC_Driving_Test_Essentials_Segment_View {
    override func layoutSubviews() {
        super.layoutSubviews()
        
        yq_segment_view.frame.origin = {
            yq_segment_view.frame.size = CGSize(width: 120 * yq_scale, height: 32 * yq_scale)
            yq_segment_view.yq_set(scale: yq_scale)
            return CGPoint(x: (frame.width - yq_segment_view.frame.width) * 0.5, y: (frame.height - yq_segment_view.frame.height - 2 * yq_scale))
        }()
    }
}
