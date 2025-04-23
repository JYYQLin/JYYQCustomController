//
//  JY_Driving_Test_Essentials_Video_List_Cell.swift
//  JY_Project_Library
//
//  Created by One Lang on 2025/4/23.
//

import UIKit
import JY_Toolbox

class JY_Driving_Test_Essentials_Video_List_Cell: JY_Base_CollectionViewCell {

    lazy var yq_title_label: JY_Label = JY_Label()
    private lazy var yq_status_view: JY_Driving_Test_Essentials_Video_Status_View = JY_Driving_Test_Essentials_Video_Status_View()
    private lazy var yq_play_status_view: JY_ImageView = JY_ImageView()
    private lazy var yq_time_label: JY_Label = JY_Label()
    private lazy var yq_underLine_imageView: JY_ImageView = JY_ImageView()

    private lazy var yq_view_model: JY_Driving_Test_Essentials_Video_View_Model = JY_Driving_Test_Essentials_Video_View_Model()
    private lazy var yq_is_play: Bool = false
}

extension JY_Driving_Test_Essentials_Video_List_Cell {
    override func yq_add_subviews() {
        super.yq_add_subviews()
        
        contentView.addSubview(yq_title_label)
        contentView.addSubview(yq_status_view)
        contentView.addSubview(yq_play_status_view)
        contentView.addSubview(yq_time_label)
    }
}

extension JY_Driving_Test_Essentials_Video_List_Cell {
    func yq_set(viewModel: JY_Driving_Test_Essentials_Video_View_Model, isPlay: Bool, scale: CGFloat) {
        yq_view_model = viewModel
        yq_is_play = isPlay
        yq_set(scale: scale)
    }
    
    static func yq_size() -> CGSize {
        return CGSize(width: 374.5, height: 59)
    }
}

extension JY_Driving_Test_Essentials_Video_List_Cell {
    override func layoutSubviews() {
        super.layoutSubviews()
        
        yq_play_status_view_frame()
        yq_time_label_frame()
        
        yq_title_label_frame()
        yq_status_view_frame()
        
        yq_underLine_imageView_frame()
        
        contentView.backgroundColor = yq_is_play == true ? UIColor.yq_color(colorString: "#F7F8FA") : UIColor.clear
    }
}

extension JY_Driving_Test_Essentials_Video_List_Cell {
    
    private func yq_underLine_imageView_frame() {
        yq_underLine_imageView.frame.origin = {
            yq_underLine_imageView.frame.size = CGSize(width: contentView.frame.width - 15 * yq_scale * 2, height: 1 * yq_scale)
            yq_underLine_imageView.image = UIImage.yq_generate_image(color: UIColor.yq_color(colorString: "#EEEEEE"), imageSize: yq_underLine_imageView.frame.size, cornerRadius: yq_underLine_imageView.frame.height * 0.5)
            return CGPoint(x: (contentView.frame.width - yq_underLine_imageView.frame.width) * 0.5, y: (contentView.frame.height - yq_underLine_imageView.frame.height))
        }()
    }
    
    private func yq_play_status_view_frame() {
        yq_play_status_view.frame.origin = {
            yq_play_status_view.frame.size = CGSize(width: 23 * yq_scale, height: 23 * yq_scale)
            
            yq_play_status_view.yq_imageName = yq_is_play == true ? "2929681c25bda20a68d67fb3dccf1810" : "173887538b18844cd0885d7b775dbe8a"
            
            return CGPoint(x: contentView.frame.width - 30 * yq_scale, y: (contentView.frame.height - yq_play_status_view.frame.height) * 0.5)
        }()
    }
    
    private func yq_time_label_frame() {
        yq_time_label.frame.origin = {
            yq_time_label.text = yq_view_model.yq_video_duration.yq_seconds_to_minutes_and_second()
            yq_time_label.font = UIFont.yq_Roboto_Regular_font(12 * yq_scale)
            yq_time_label.textColor = UIColor.yq_color(colorString: "#616161")
            yq_time_label.sizeToFit()
            return CGPoint(x: yq_play_status_view.frame.minX - yq_time_label.frame.width - 10 * yq_scale, y: (contentView.frame.height - yq_time_label.frame.height) * 0.5)
        }()
    }
    
    private func yq_title_label_frame() {
        yq_title_label.frame.origin = {
            yq_title_label.text = yq_view_model.yq_title
            yq_title_label.font = UIFont.yq_system_font(15 * yq_scale)
            yq_title_label.textColor = UIColor.yq_color(colorString: "#424242")
            
            let maxWidth = 190 * yq_scale
            yq_title_label.sizeToFit()
            
            if yq_title_label.frame.width >= maxWidth {
                yq_title_label.frame.size.width = maxWidth
            }
            
            return CGPoint(x: 15 * yq_scale, y: (contentView.frame.height - yq_title_label.frame.height) * 0.5)
        }()
    }
    
    private func yq_status_view_frame() {
        yq_status_view.frame.origin = {
            
            var status = yq_view_model.yq_is_unlock == true ? JY_Driving_Test_Essentials_Video_Status.unlocked : JY_Driving_Test_Essentials_Video_Status.unkown
            
            if yq_is_play == true {
                status = .playing
            }
            
            yq_status_view.frame.size = yq_status_view.yq_size(status: status, scale: yq_scale)
            return CGPoint(x: yq_title_label.frame.maxX + 6 * yq_scale, y: (contentView.frame.height - yq_status_view.frame.height) * 0.5)
        }()
    }
}
