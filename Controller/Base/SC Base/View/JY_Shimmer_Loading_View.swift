//
//  JY_Shimmer_Loading_View.swift
//  JYYQCustomController
//
//  Created by JYYQLin on 2025/4/23.
//

import UIKit
import JY_Toolbox

class JY_Shimmer_Loading_View: JY_View {

    private lazy var yq_bg_imageView: UIImageView = UIImageView()
    private lazy var yq_imageView: UIImageView = UIImageView()
    private lazy var yq_shimmerView: JY_ShimmeringView = JY_ShimmeringView()
}

extension JY_Shimmer_Loading_View {
    override func yq_add_subviews() {
        super.yq_add_subviews()
        
        addSubview(yq_bg_imageView)
        addSubview(yq_shimmerView)
        
        yq_shimmerView.contentView = yq_imageView
        yq_shimmerView.isShimmering = true
        yq_shimmerView.shimmerSpeed = 105
        yq_shimmerView.shimmerPauseDuration = 0.8
    }
}

extension JY_Shimmer_Loading_View {
    override func layoutSubviews() {
        super.layoutSubviews()
        
        yq_bg_imageView.frame.origin = {
            yq_bg_imageView.frame.size = bounds.size
            yq_bg_imageView.image = UIImage.yq_generate_image(color: UIColor.yq_color(colorString: "#050505").withAlphaComponent(0.66), imageSize: yq_bg_imageView.frame.size, cornerRadius: 15 * yq_scale, roundingCorners: .allCorners)
            return bounds.origin
        }()
        
        yq_imageView.frame.origin = {
            yq_imageView.image = UIImage(named: "cdbe3f649f0efa7445fb157a44cf7ed2")
            yq_imageView.frame.size = CGSize(width: 29 * yq_scale, height: 29 * yq_scale)
            return CGPoint(x: 0, y: 0)
        }()
        
        yq_shimmerView.frame = CGRect(x: (frame.width - yq_imageView.frame.width) * 0.5, y: (frame.height - yq_imageView.frame.height) * 0.5, width: yq_imageView.frame.width, height: yq_imageView.frame.height)
        yq_shimmerView.isShimmering = true
    }
}
