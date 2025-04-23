//
//  JY_Driving_Test_Essentials_Directory_Title_Cell.swift
//  JYYQCustomController
//
//  Created by JYYQLin on 2025/4/23.
//

import UIKit
import JY_Toolbox

class JY_Driving_Test_Essentials_Directory_Title_Cell: JY_Base_CollectionViewCell {

    private lazy var yq_is_selected: Bool = false
        
    private lazy var yq_bgImageView: JY_ImageView = JY_ImageView()
    private lazy var yq_title_label: JY_Label = JY_Label()
    
}

extension JY_Driving_Test_Essentials_Directory_Title_Cell {
    func yq_set(title: String, isSelected: Bool, scale: CGFloat) {
        yq_title_label.text = title
        yq_is_selected = isSelected
        yq_set(scale: scale)
    }
    
    func yq_size(title: String, scale: CGFloat) -> CGSize {
        yq_title_label.text = title
        yq_set(scale: scale)
        yq_title_label_frame()
        return CGSize(width: yq_title_label.frame.width + 18 * scale * 2, height: yq_title_label.frame.height + 5 * scale * 2)
    }
}

extension JY_Driving_Test_Essentials_Directory_Title_Cell {
    override func yq_add_subviews() {
        super.yq_add_subviews()
        
        contentView.addSubview(yq_bgImageView)
        contentView.addSubview(yq_title_label)
    }
}

extension JY_Driving_Test_Essentials_Directory_Title_Cell {
    override func layoutSubviews() {
        super.layoutSubviews()
        
        yq_bgImageView_frame()
        yq_title_label_frame()
    }
    
    private func yq_bgImageView_frame() {
        yq_bgImageView.frame.origin = {
            yq_bgImageView.frame.size = contentView.frame.size
            
            let normalImage = UIImage.yq_generate_image(color: UIColor.yq_color(colorString: "#F7F8FA"), imageSize: yq_bgImageView.frame.size, cornerRadius: yq_bgImageView.frame.height * 0.5)
            let selectedImage = UIImage.yq_generate_image(color: UIColor.yq_color(colorString: "#EAF1FF"), imageSize: yq_bgImageView.frame.size, cornerRadius: yq_bgImageView.frame.height * 0.5)
            
            yq_bgImageView.image = yq_is_selected == true ? selectedImage : normalImage
            
            return contentView.frame.origin
        }()
    }
    
    private func yq_title_label_frame() {
        yq_title_label.frame.origin = {
            yq_title_label.font = UIFont.systemFont(ofSize: 13 * yq_scale)
            yq_title_label.textColor = yq_is_selected == true ? UIColor.yq_color(colorString: "#3377FF") : UIColor.yq_color(colorString: "#424242")
            yq_title_label.sizeToFit()
            return CGPoint(x: (contentView.frame.width - yq_title_label.frame.width) * 0.5, y: (contentView.frame.height - yq_title_label.frame.height) * 0.5)
        }()
    }
}
