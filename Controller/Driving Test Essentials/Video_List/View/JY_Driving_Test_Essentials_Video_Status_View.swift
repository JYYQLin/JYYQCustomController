//
//  JY_Driving_Test_Essentials_Video_Status_View.swift
//  JY_Project_Library
//
//  Created by One Lang on 2025/4/23.
//

import UIKit
import JY_Toolbox

enum JY_Driving_Test_Essentials_Video_Status: String {
    
    case unlocked = "未解锁"
    case playing = "正在播放"
    
    case unkown = "未知"
}

class JY_Driving_Test_Essentials_Video_Status_View: JY_ImageView {

    private lazy var yq_title_label: JY_Label = JY_Label()
    private lazy var yq_status: JY_Driving_Test_Essentials_Video_Status = .unkown
}

extension JY_Driving_Test_Essentials_Video_Status_View {
    override func yq_add_subviews() {
        super.yq_add_subviews()
        
        addSubview(yq_title_label)
    }
}

extension JY_Driving_Test_Essentials_Video_Status_View {
    func yq_size(status: JY_Driving_Test_Essentials_Video_Status, scale: CGFloat) -> CGSize {
        yq_status = status
        yq_set(scale: scale)
        yq_title_label_frame()
        
        if status == .unkown {
            return .zero
        }
        else{
            return CGSize(width: yq_title_label.frame.width + 4 * 2 * scale, height: yq_title_label.frame.height + 2 * 2 * scale)
        }
    }
}

extension JY_Driving_Test_Essentials_Video_Status_View {
    override func layoutSubviews() {
        super.layoutSubviews()
     
        yq_title_label_frame()
        
        let bgColor = yq_status == .playing ? UIColor.yq_color(colorString: "#3377FF") : UIColor.yq_color(colorString: "#FF6A08")
        self.image = UIImage.yq_generate_image(color: bgColor, imageSize: bounds.size, cornerRadius: 4 * yq_scale)
    }
    
    private func yq_title_label_frame() {
        yq_title_label.frame.origin = {
            yq_title_label.text = yq_status.rawValue
            yq_title_label.textColor = UIColor.yq_color(colorString: "#FAFAFA")
            yq_title_label.font = UIFont.yq_medium_font(11 * yq_scale)
            yq_title_label.sizeToFit()
            return CGPoint(x: (frame.width - yq_title_label.frame.width) * 0.5, y: (frame.height - yq_title_label.frame.height) * 0.5)
        }()
    }
}

